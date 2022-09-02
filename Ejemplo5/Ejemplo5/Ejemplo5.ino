#include <Servo.h>
Servo servo;
int angulo = 10;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  servo.attach(9);
  servo.write(0);
}

void loop() {
  // put your main code here, to run repeatedly:
  for(angulo = 0; angulo <= 180; angulo += 1){
    servo.write(angulo);
    delay(1000);
  }
}
