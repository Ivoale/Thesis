# -*- coding: utf-8 -*-

# Returns temperature in DegC, double precision. Output value of “51.23” equals 51.23 DegC.
# t_fine carries fine temperature as global value
def compensate_T(adc_T, params):#, sensorID):
    #double var1, var2, T;
    global t_fine

    c1 = 16384.0
    c2 = 1024.0
    c3 = 131072.0
    c4 = 8192.0
    c5 = 5120.0

    #Split parameter columns
    dig_T1 = params[:,0]
    dig_T2 = params[:,1]
    dig_T3 = params[:,2]

    #T = np.empty(adc_T_arr.shape[0])
    #for i, adc_T in enumerate(adc_T_arr):
    #    a = (adc_T / c1 - dig_T1 / c2) * dig_T2
    #    b = ((adc_T / c3 - dig_T1 / c4) ** 2 ) * dig_T3
    #    t_fine = a + b
    #    T[i] = (a + b) / c5

    a = (adc_T / c1 - dig_T1 / c2) * dig_T2
    b = ((adc_T / c3 - dig_T1 / c4) ** 2 ) * dig_T3

    T = (a + b)/c5

    return T


# Returns pressure in Pa as double. Output value of “96386.2” equals 96386.2 Pa = 963.862 hPa
def compensate_P(adc_P, params,T):#, sensorID):
    #global t_fine
    c1 = 64000.0
    c2 = 32768.0
    c3 = 65536.0
    c4 = 524288.0
    c5 = 1048576.0
    c6 = 4096.0
    c7 = 6250.0
    c8 = 2147483648.0

    #Split parameter columns
    dig_P1 = params[:,0]
    dig_P2 = params[:,1]
    dig_P3 = params[:,2]
    dig_P4 = params[:,3]
    dig_P5 = params[:,4]
    dig_P6 = params[:,5]
    dig_P7 = params[:,6]
    dig_P8 = params[:,7]
    dig_P9 = params[:,8]
    
    #a = (t_fine / 2.0) - c1
    a = (T / 2.0) - c1
    b = (a*a * dig_P6 / c2) + a * dig_P5 * 2.0
    d = (b/4.0) + (dig_P4 * c3)
    e = (dig_P3 * a*a / c4 + dig_P2 * a) / c4
    f = (1.0 + e / c2) * dig_P1

    if (any(f == 0.0)):
        return 0 # avoid exception caused by division by zero

    p1 = c5 - adc_P
    p2 = (p1 - d / c6) * c7 / f
    g = dig_P9 * p2*p2 / c8
    h = p2 * dig_P8 / c2

    P = p2 + (g + h + dig_P7) / 16.0


    return P

