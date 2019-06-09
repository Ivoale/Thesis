#Author: Jonathon Taufatofua

import serial
import time, datetime
import serial.tools.list_ports as serialports 
import numpy as np
import struct
import io
import os
import atexit

from compensate import compensate_T, compensate_P

import tkinter as tk
from tkinter import filedialog


#import rospy
from messages import WhiskerCalib, WhiskerTemperature, WhiskerPressure #, WhiskerCalibArray ,WhiskerArray, WhiskerCmd

class WhiskerArrayReader:
    def __init__(self, topicRoot):
        self.ports = {}       #Opened serial ports - {str(board ID): Serial object}
        self.portnames = {}   #Port names - {str(board ID): str(USB COM port names (eg COM3 or /dev/ttyACM2)}
        self.nBoards = 0      #Number of opened serial ports
        
        self.nSensors = 12    #Nummber of sensors per whisker board. COULD CHANGE!!! TO DO: MAKE MORE ROBUST
        
        
        self.msgT = WhiskerTemperature()
        self.msgT.nSensors  = self.nSensors     
        self.msgT.adc_T = [0]*self.nSensors#np.zeros([self.nSensors])
        
        self.msgP = WhiskerPressure()
        self.msgP.nSensors  = self.nSensors     
        self.msgP.adc_P = [0]*self.nSensors#np.zeros([self.nSensors])
      
        self.nCalibParams = 19    #Number of calibration parameters for board               
             
        self.msgCalib = WhiskerCalib()
        self.msgCalib.n_kT = 3
        self.msgCalib.n_kP = 9
        self.msgCalib.kT = [0]*self.msgCalib.n_kT
        self.msgCalib.kP = [0]*self.msgCalib.n_kP
        
            
        self.find_ports('whisker_board')
        self.open_serial_ports()

        # Configure file IO
        root = tk.Tk()
        root.withdraw()
        file_path = filedialog.askdirectory(title = "Choose your workspace", initialdir=os.getcwd())
        self.setDataFolder(file_path+"/data") #Generates self.dataDir

      
    #---------------------- SERIAL ----------------------#
    def find_ports(self, target_device):#, vid=None, pid=None, uid=None):
        """
        Looks through available serial ports for a device with a particular
        VendorID and ProductID and unique ID
        Returns port string or None if not found.

        find_port(str) -> [str(port),str(SNR)] OR []
        """
        #Map devices to (VID, PID, SER) as strings
        devices = {
              
              'arduino_uno':          (0x2A03, 0x0043),
              'arduino_mega2560':     (0x2341, 0x0242),
              'whisker_board':        (0x0483, 0x5740),
              'teensy_3_2':           (0x16C0, 0x0483),
              }
        target_params = devices[target_device] #Retrieve target IDs
                      
        board_ids = [self.ports.keys()]#Board serial numbers (each should be unique)
      
        i = 1

        print("Adding device...")
        for port in serialports.comports(): #Scan available COM ports
            if ((port.pid is None) or (port.vid is None)): #Ignore devices without product information
                continue
            id = int(port.serial_number, 16) #Convert hex ID to int

            #Check VID and PID are consistent
            if (port.vid == target_params[0] and #VID
                port.pid == target_params[1]): #PID
                print('\t{} on {}'.format(target_device, port.device))

                try:                        
                    i_id = board_ids.index(id)
                                        
                    #MEANTIME - keep all entries (REMOVE THIS WHEN IDs ARE UNIQUE!)
                    id = (i<<8) + id
                    i+=1
                    print('\t...duplicate ID! Modifying duplicate {:0>12x} to {:0>12x}'.format(board_ids[i_id],id)) 
                        
                except ValueError:
                        board_ids.append(id)

                self.portnames[id]=port[0]  #Assign ID to port
                self.ports[id]=None         #Assuming all ports are closed at this point. 
                                                                        #TO DO: CHECK FOR PORTS WHICH ALREADY MATCH EXISTING

                return port.device
                
        print("{} device(s) found at: {}".format(len(self.portnames),list(self.portnames.values())))                            
    
    def open_serial_ports(self, baud = 115200):
    
        print("Opening ports...")
        if len(self.portnames)==0:
            print("No devices found!")
            raise SystemExit
        devices = self.ports.keys()
        for id in devices: 
            self.ports[id] = serial.Serial(self.portnames[id], baud, timeout = 2)  
            print("\t{}".format(self.portnames[id]))
        atexit.register(self.close_serial_ports) #Arrange to close ports on system exit
        
        self.nBoards = len(self.ports) #Set number of open boards
        
    def close_serial_ports(self):
        print("Closing serial ports...")
        
        for port in self.ports.values():
            print("\t{}".format(port.port))
            port.close()
        self.ports = {}
            
        print("Done!")
    
    #---------------------- SERIAL IO ----------------------#

    def write_serial(self, port, txStr):
      
        port.write(txStr.encode('utf-8'))

    def read_serial(self, port):
        if (port.inWaiting()>0): #Data available to be read
            packet = self.get_packet(port)
            if (packet is not None):
                return packet
        return None #Failed packet
    
    def get_packet(self, port):
        """
        Pressure (44): [header (2), timestamp (4), sensor 1-12 (12x3, ignore LSB), footer(2)]
        Temp     (44): [header (2), timestamp (4), sensor 1-12 (3, ignore LSB), footer(2)]
        Calib    (44): [header (2), timestamp (4), calib data (varies, endianess varies), footer(2)]
        """
        PACKET_LENGTH = 44 #Number of bytes per packet
        packet = ""
        
        #Read first byte. Ignore incorrect header character
        rxChar = port.read(1) 
        if (rxChar != b'U'):
            return None
        
        packet = rxChar + port.read(PACKET_LENGTH-1) #Read full packet (b'U' + 43 bytes)
        if (len(packet) != PACKET_LENGTH):
            return None
        
        t = time.time()
        
        #Extract header and footer and check if valid
        header = packet[0:2]
        footer = packet[-2:]   
        #Check for valid packet types
        if (header == b'UQ' and footer == b'WD'):   #Pressure
            return('P', packet[2:-2], t)
        elif (header == b'UY' and footer == b'XE'): #Temperature
            return('T', packet[2:-2], t)
        elif (header == b'UZ' and footer == b'YF'): #Calibration parameters
            return('C', packet[2:-2], t)
    
        return None
        
    #---------------------- SERIAL COMMANDS ----------------------#

    def setDataMode(self, mode):
        """
        Set board data mode. Valid <mode> should be one of:
            0 - (default) stream P at 100Hz
            1 - only get data (T/P/calibration) on request
            2 - stream P at 100Hz and T at 10Hz
        Note: does not check mode validity.
        """
        for port in self.ports.values():
            self.write_serial(port,'[SM{}]'.format(mode)) 
    
    def setDefaultDataMode(self, tPause = 0.5):
        """
        Default mode: Mode 2 - stream P at 100Hz and T at 10Hz
        """
        self.setDataMode(0) 
        time.sleep(tPause)     #Wait for tPause seconds
    
    def get_pressures(self, id):
        """
        Pressure (44): [header (2), timestamp (4), sensor 1-12 (12x3, ignore LSB), footer(2)]
        """ 
        port = self.ports[id]
        data = self.read_serial(port)
        if (data is None):
            return False
        elif (data[0] == 'P'): #Ignore everything except P packets
            self.msgP.ID  = id
            self.msgP.header.stamp = data[2] 
            self.msgP.tuC =  struct.unpack('>I',data[1][0:4])[0]
            for i in range(self.nSensors):
                j = 4 + i*3
                self.msgP.adc_P[i] = int.from_bytes(data[1][j:j+3], byteorder = 'big', signed=False)
               

            #Compile data file row
            row  = np.empty([27])
            row[0] = self.msgP.ID
            row[1] = self.msgP.header.stamp
            row[2] = self.msgP.tuC
            row[3:15] = self.msgP.adc_P
                
            self.write_row(self.dataFile, row)
                                          
            return True
        return False

    
    ##request temperature     
    def request_calib_params(self):
        """
        Calib    (44): [header (2), timestamp (4), calib data (varies, endianess varies), footer(2)]
        """
        #Clear kT and kP data
        
        self.msgCalib.kT = [0]*self.msgCalib.n_kT
        self.msgCalib.kP = [0]*self.msgCalib.n_kP
       
        
        self.setDataMode(1)    #1 - request mode
        time.sleep(0.5)         #Wait 0.5 seconds
   
        self.calibs = []

        
        for i_board, id in enumerate(self.ports.keys()):
            port = self.ports[id]
            self.msgCalib.ID_board = id
            for i in range(self.nSensors):
                #Request calibration data
                self.write_serial(port,'[CP{:x}]'.format(i+1).upper()) #hex format for i
                
                calib = False
                while(calib == False): #TO DO: FIX Tight loop - wait for response
                    data = self.read_serial(port)
                    if (data is None): continue
                    elif (data[0] == 'C'):
                        

                        j = int(data[1][35]-1)

                        #CHECK FOR MISMATCHED SENSORS!
                        if(i != j):
                            print("Sensor mismatch! {}-{}".format(i,j))
                            continue                            #IGNORE PACKET

                        #Unpack data from packet
                        self.msgCalib.header.stamp = data[2] 
                        self.msgCalib.ID_sensor =   j
                        self.msgCalib.tuC =         struct.unpack('>I',data[1][0:4])[0]
                        self.msgCalib.kT =          struct.unpack('<Hhh',data[1][4:10]) #T1, T2, T3             
                        self.msgCalib.kP =          struct.unpack('<H8h',data[1][10:28])#P1...P9, ID
                        self.msgCalib.boardType =   data[1][28]
                        self.msgCalib.mode =        data[1][36]
                        self.msgCalib.t_sample =    struct.unpack('>H',data[1][37:39])[0]
                        self.msgCalib.version =     data[1][39]

                        #Build row for output file
                        row  = np.empty([self.nCalibCols])
                        row[0] = self.msgCalib.ID_board
                        row[1] = self.msgCalib.ID_sensor
                        row[2] = self.msgCalib.mode
                        row[3] = self.msgCalib.t_sample
                        row[4] = self.msgCalib.boardType
                        row[5] = self.msgCalib.version
                        row[6] = self.msgCalib.header.stamp
                        row[7] = self.msgCalib.tuC
                        row[8:11] = self.msgCalib.kT
                        row[11:20] = self.msgCalib.kP
                    
                        #Publish for each sensor separately 
                        
                        self.write_row(self.paramsFile, row)
                        
                        
                        calib = True
                    time.sleep(0.000001)   ##0.0001
                                            
           
        #Return to streaming P,T
        self.setDefaultDataMode()
    
    #---------------------- DATA FOLDER ----------------------#

    def setDataFolder(self, dirName):
        if (not os.path.isdir(dirName)):
            os.mkdir(dirName)
            print("Created data directory in: {}".format(dirName))
        self.dataDir = dirName
        return True

    #---------------------- CALIBRATION FILE ----------------------#
        

    def initCalibFile(self, filename):
        #global nBoards, nSensors
        
        
        nSensorsTot = self.nBoards*self.nSensors
       

        nRows = nSensorsTot        
        nCols = 22
        self.nCalibCols = nCols
        arrCalib = np.empty([nRows, nCols])

        
        #print headers
        headers = "Board ID, Sensor ID, Mode, Sampling Interval (ms),ID Class,Firmware Version,"+\
                  "System Timestamp (ms),uC Timestamp (ms),"+\
                  "T1,T2,T3,P1,P2,P3,P4,P5,P6,P7,P8,P9,ADC_P,ADC_T"

        self.calibFile = filename+"_params.csv"
        
               
        with open(self.calibFile,'wb') as self.paramsFile:

       
            
            np.savetxt(self.paramsFile, np.empty(0), header=headers, delimiter=",") #Save top matter

           
            self.request_calib_params()

     
            
        np.set_printoptions(suppress=True)
        
      
        return True


    #---------------------- DATA FILE IO ----------------------#
            
    def write_data_headers(self, outFile):
        #global nBoards, nSensors
        if (not isinstance(outFile, io.BufferedWriter) or outFile.closed):
            return False
        
        return True

    def create_data_row(iBoard,pressures,temps):  
        row = np.empty(27)
        row[0]     = iBoard
        row[1:3]   = pressures[0:2] #Use pressure timestamps
        row[3:15]  = pressures[2:14] #12 pressure values
        
        return row

    def write_row(self, outFile, row):
        row.tofile(outFile, ',')
        outFile.write(b'\n')

    #---------------------- MAIN ----------------------#
        
    def run(self, filename = ""):

        print(self.dataDir+"/"+filename)
        
        print("Initialising calibration file...")
        self.initCalibFile(self.dataDir+"/"+filename)

        print("Initialising data file...")
        self.write_data_headers(self.dataFile)
        
      
        #Set to streaming P,T
        self.setDefaultDataMode()

        runtime = 50 #Runtime in seconds

             
        print("Collecting data...")
        rate = 1.0/10000 #loop every 1/10000 seconds
        self.t0 = time.time()
        
        while ((time.time()-self.t0) < runtime):
            if (((time.time()-self.t0)  < 5) & ((time.time()-self.t0)  > 4.5)):
                print("5 seconds: FLICK")                
                               
            if (((time.time()-self.t0)  < 10) & ((time.time()-self.t0)  > 9.5)):
                print("10 seconds: TIP")
                
                #next movement is flick (usually takes 1 second)
            if (((time.time()-self.t0)  < 30) & ((time.time()-self.t0)  > 29.5)):
                print("30 seconds: HOLD")

            if (((time.time()-self.t0)  < 40) & ((time.time()-self.t0)  > 39.5)):
                print("40 seconds: BRUSH")
                
         
            for id in self.ports.keys():
                self.get_pressures(id)

                 
       
        print("Completed!")
       

    
if __name__ == "__main__":

    array = WhiskerArrayReader('/pps')

    filename = "tester"
    fileOut = array.dataDir+"/"+filename+"_data.csv"
    with open(fileOut,'wb') as array.dataFile:
        array.run(filename)
    
    fileTex = array.dataDir+"/"+"now.txt"
    f = open(fileTex,"w+")       
    f.write("1\n")
    f.close()
    print("Finished!")
