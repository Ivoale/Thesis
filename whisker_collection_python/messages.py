#!/usr/bin/env python3

import numpy as np
#import time, datetime
#from math import inf
      
class Header():
    def __init__(self):
        self.stamp = None
    def __str__(self):
        return("header:\n\tstamp: {}".format(self.stamp))

class WhiskerCalib():
    def __init__(self):#, nSensors):
        self.header = Header()
        self.ID_board = ""
        self.ID_sensor = 0
        self.tuC = 0
        self.boardType = 0xFF
        self.mode = -1
        self.t_sample = 0
        self.version = ""
        self.nSensors = 0#nSensors
        self.n_kT = 3
        self.n_kP = 9
        self.kT = np.zeros(self.nSensors)#[0]*self.n_kT #np.zeros([self.nSensors, self.n_kT])#np.zeros([self.msgCalib.n_kT])
        self.kP = np.zeros(self.nSensors)#[0]*self.n_kP #np.zeros([self.nSensors, self.n_kP])#np.zeros([self.msgCalib.n_kP])

class WhiskerTemperature():
    def __init__(self):#, nSensors):
        self.header = Header()
        self.ID = ""
        self.nSensors  = 0#nSensors
        self.tuC = 0
        self.adc_T = np.zeros(self.nSensors)#[0]*self.nSensors #np.zeros([self.nSensors,1])

class WhiskerPressure():
    def __init__(self):#, nSensors):
        self.header = Header()
        self.ID = ""
        self.nSensors = 0#nSensors
        self.tuC = 0
        self.adc_P = np.zeros(self.nSensors)#[0]*self.nSensors #np.zeros([self.nSensors,1])

    def __str__(self):
        return("{}\nID: {}\nnSensors: {}\nadc_P: {}\n".format(self.header,self.ID,self.nSensors,self.adc_P))


