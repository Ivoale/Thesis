/*
  Pan and tilt motors are moved with different velocities
  according the parameters:
  angles 
  delays (time or duration)
  The motors move when the respective buttons are pressed

  created in 2019
  by Ivonne Vera Pauta
 
*/
#include <Servo.h>

const int buttonPin_hold = 27;     // the number of the pushbutton hold pin
const int buttonPin_brush = 26;     // the number of the pushbutton brush pin
const int buttonPin_tip = 14;     // the number of the pushbutton tip pin
const int buttonPin_flick = 12;     // the number of the pushbutton flick pin
const int ledPin =  2;      // the number of the LED pin

static const int servoPin = 4;    //the pin for the pan motor
static const int servoTilt = 13;  //the pin for the tilt motor


// variables that change:
int buttonState_hold = 0;         // variable for reading the hold pushbutton status
int buttonState_brush = 0;         // variable for reading the brush pushbutton status

int buttonState_tip = 0;         // variable for reading the tip pushbutton status

int buttonState_flick = 0;         // variable for reading the flick pushbutton status

Servo servo1;               //define the class for pan servo
Servo servo2;               //define the class for tilt servo


void setup() {
  
  // initialize the LED pin as an output:
  pinMode(ledPin, OUTPUT);
  
  // initialize the pushbutton pins as inputs:
  pinMode(buttonPin_hold, INPUT);
  pinMode(buttonPin_brush, INPUT);
  pinMode(buttonPin_tip, INPUT);
  pinMode(buttonPin_flick, INPUT);

  // attach the pin of the motors to the servo classes
  servo1.attach(servoPin);
  servo2.attach(servoTilt);
}

void loop() {
  
  // read the state of the pushbutton values:
  buttonState_hold = digitalRead(buttonPin_hold);
  buttonState_brush = digitalRead(buttonPin_brush);
  buttonState_tip = digitalRead(buttonPin_tip);
  buttonState_flick = digitalRead(buttonPin_flick);

  //////HOLD/////HOLD////HOLD////HOLD
  if (buttonState_hold == HIGH) {
    // turn LED on:
    digitalWrite(ledPin, HIGH);
    servo1.write(23);
    delay(1500);
    servo1.write(0);    
  } else {
    // turn LED off:
    digitalWrite(ledPin, LOW);    
  }
  
  //////BRUSH////BRUSH/////BRUSH/////BRUSH
  if (buttonState_brush == HIGH) {
    // turn LED on:
    digitalWrite(ledPin, HIGH);
    for(int posDegrees = 0; posDegrees <= 70; posDegrees++) {
        servo1.write(posDegrees);        
        Serial.println(posDegrees);
        delay(100);    }
  } else {
    // turn LED off:
    digitalWrite(ledPin, LOW);
  }

  /////TIP/////TIP////TIP////TIP////TIP
  if (buttonState_tip == HIGH) {
    // turn LED on:
    digitalWrite(ledPin, HIGH);
    for(int posDegrees = 90; posDegrees <= 150; posDegrees++) {
        servo2.write(posDegrees);        
        Serial.println(posDegrees);
        delay(200);
    }    
    servo2.write(90); 
  } else {
    // turn LED off:
    digitalWrite(ledPin, LOW);
  }

  ///////FLICK////FLICK////FLICK/////FLICK
  if (buttonState_flick == HIGH) {
    // turn LED on:
    digitalWrite(ledPin, HIGH);
    servo1.write(23);
    delay(500);
    servo1.write(0);
  } else {
    // turn LED off:
    digitalWrite(ledPin, LOW);    
  }
}
