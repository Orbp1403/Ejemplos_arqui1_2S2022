#include <Wire.h>

char cadena[] = "hola soy el maestro";

void setup() {
  // put your setup code here, to run once:
  Wire.begin();
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  Wire.beginTransmission(1);
  Wire.write(cadena, sizeof(cadena));
  Wire.endTransmission();
  Serial.print("Enviado: ");
  Serial.println(cadena);
  delay(2000);
/*  Wire.requestFrom(1, 1);
  int cantidad = Wire.read();
  Wire.requestFrom(1, cantidad);
  char contenido[cantidad] = "";*/
  Wire.requestFrom(1, 100);
  char contenido[100];
  int indice = 0;
  while(Wire.available()){
    int recibido = Wire.read();
    if(recibido != 255){
      contenido[indice] = (char)recibido;
      indice++;  
    }
  }
  Serial.print("Recibido: ");
  Serial.println(contenido);
}
