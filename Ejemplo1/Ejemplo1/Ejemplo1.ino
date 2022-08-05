int pinentrada = 22;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(pinentrada, INPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(digitalRead(pinentrada) == HIGH){
    Serial.println('H');
  }else{
    Serial.println('L');
  }
}
