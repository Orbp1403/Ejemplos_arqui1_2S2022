#include <EEPROM.h>

struct persona{
  int edad;
  char nombre[10];
};

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Serial1.begin(9600);
  persona datos = {
    28,
    "Oscar"
  };
  /*for(int i = 0; i < 255; i++){
    //Serial.println(EEPROM.read(i));
    EEPROM.write(i, i);
  }*/
  for(int i = 0; i < 255; i++){
    Serial.println(EEPROM.read(i));
  }
  //EEPROM.put(0, datos);

  persona datos1;
  EEPROM.get(0,datos1);

  Serial.print("La edad es ");
  Serial.print(datos1.edad);
  Serial.print(" y mi nombre es ");
  Serial.println(datos1.nombre);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(Serial1.available()){
    char caracter = Serial1.read();
    Serial.print(caracter);
    Serial.println();
  }
  
}
