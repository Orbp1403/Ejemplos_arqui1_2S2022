#include <Wire.h>

bool cantidadenviada = false;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  Wire.begin(1);
  Wire.onReceive(eventorecibe);
  Wire.onRequest(eventosolicitud);
}

void loop() {
  // put your main code here, to run repeatedly:

}

void eventorecibe(int numerobytes){
  char mensajerecibido[numerobytes];
  for(int i = 0; i < numerobytes; i++){
    mensajerecibido[i] = Wire.read();
  }
  Serial.println(mensajerecibido);
}

void eventosolicitud(){
  char envio[] = "hola soy el esclavo";
  /*if(!cantidadenviada){
    Wire.write(sizeof(envio));
  }else{*/
    Wire.write(envio); 
  /*}
  cantidadenviada = !cantidadenviada;*/
}
