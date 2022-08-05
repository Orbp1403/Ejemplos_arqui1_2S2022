#include "figuras.h"
int columnas[] = {22, 23, 24, 25, 26, 27, 28, 29};
int filas[] = {46, 47, 48, 49, 50, 51, 52, 53};
int letra[][8]={
  {0, 0, 0, 0, 0, 0, 0, 0},//1
  {0, 0, 0, 0, 0, 0, 0, 0},//2
  {0, 0, 0, 0, 0, 0, 0, 0},//3
  {0, 0, 0, 0, 0, 0, 0, 0},//4
  {0, 0, 0, 0, 0, 0, 0, 0},//5
  {0, 0, 0, 0, 0, 0, 0, 0},//6
  {0, 0, 0, 0, 0, 0, 0, 0},//7
  {0, 0, 0, 0, 0, 0, 0, 0},//8
};

void setup() {
  // put your setup code here, to run once:
  for(int i = 0; i < 8; i++){
    pinMode(filas[i], OUTPUT);
    pinMode(columnas[i], OUTPUT);
  }
  LimpiarMatriz();
}

void loop() {
  // put your main code here, to run repeatedly:
  //BARRIDO CON COLUMNAS Y FILAS
  //for(int fila = 0; fila < 8; fila++){
    //digitalWrite(filas[fila], HIGH);
//    for(int col = 0; col < 8; col++){
      //digitalWrite(columnas[col], LOW);
      //delay(500);
      //digitalWrite(columnas[col], HIGH);
    //}
    //digitalWrite(filas[fila], LOW);
  //}
  //BARRIDO POR FILAS Y COLUMNAS
//  for(int col = 0; col < 8; col++){
  //  digitalWrite(columnas[col], LOW);
    //for(int fila = 0; fila < 8; fila++){
//      digitalWrite(filas[fila], HIGH);
  //    delay(200);
    //  digitalWrite(filas[fila], LOW);
//    }
  //  digitalWrite(columnas[col], HIGH);
  //}
  for(int col = 0; col < 8; col++){
    for(int fila = 0; fila < 8; fila++){
      letra[col][fila] = a[col][fila];
    }
  }
  for(int col = 0; col < 8; col++){
    digitalWrite(columnas[col], LOW);
    for(int fila = 0; fila < 8; fila++){
      if(letra[col][fila] == 1){
        digitalWrite(filas[fila], HIGH); 
      }
    }
    delay(1);
    digitalWrite(columnas[col], HIGH);
    for(int fila = 0; fila < 8; fila++){
      digitalWrite(filas[fila], LOW);
    }
  }
  LimpiarMatriz();
}

void LimpiarMatriz(){
  for(int i = 0; i < 8; i++){
    digitalWrite(filas[i], LOW);
    digitalWrite(columnas[i], HIGH);
  }
}
