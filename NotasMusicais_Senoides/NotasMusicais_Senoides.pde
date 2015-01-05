/*
This is a sine-wave oscillator. The method .play() starts the oscillator. There
are several setters like .amp(), .freq(), .pan() and .add(). If you want to set all of them at
the same time use .set(float freq, float amp, float add, float pan)
*/

import processing.sound.*;
import TUIO.*;

SinOsc sine;
TuioProcessing tuioClient;


float n_do =261.6;
  float n_do_su=278;
float n_re =294;
float n_mi =330;
float n_fa =394;
float n_sol=392;
float n_la =440;
float n_si =495;

float freq=0.0;//400
float amp=0.0;//0.5
float pos;

// para calcular a rotação infinitamente. 
// Para avaliar se o objeto está girando, com o intuito de aumentar valores.
// Basicamente, o desejo aqui, é detectar o sentido da rotação, para saber se um certo valor,
// deve ser aumentado, ou reduzido. 
// Tal qual um botão de aumento de volume, so que, sem limite de alta, ou baixa.
float current_ang;
float ang_before;
float full_rot=0;
float target_value=0;

void setup() {
    size(640, 360);
    background(255);
    
    // Create and start the sine oscillator.
    sine = new SinOsc(this);
    
    //Start the Sine Oscillator. 
    sine.play();
    
    //TUIO
    frameRate(30);
    //noLoop();

    //hint(ENABLE_NATIVE_FONTS);
    //font = createFont("Arial", 18);
    //scale_factor = height/table_size;

    // we create an instance of the TuioProcessing client
    // since we add "this" class as an argument the TuioProcessing class expects
    // an implementation of the TUIO callback methods (see below)
    tuioClient  = new TuioProcessing(this);
}

void draw() {

  // Map mouseY from 0.0 to 1.0 for amplitude
  //amp=map(mouseY, 0, height, 1.0, 0.0);
  //sine.amp(amp);
  println( "Amplitude: "+ amp );
  sine.amp(amp);
  
  // Map mouseX from 20Hz to 1000Hz for frequency  
  //freq=map(mouseX, 0, width, 80.0, 1000.0);
  sine.freq(freq);
  
  // Map mouseX from -1.0 to 1.0 for left to right 
  //pos=map(mouseX, 0, width, -1.0, 1.0);
  sine.pan(0);
}


/* ---------------------------------------------------------------------
  TUIO reacTIVision
--------------------------------------------------------------------- */

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  //println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  //println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" angle: "+tobj.getAngle()+" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());

  //println("Rotação --------------------------------------------------");
  //println("angulo do reactivision: "+ tobj.getAngle());
  float ang = (360*tobj.getAngle())/6.28;
  float ang_degree = (360*tobj.getAngle())/6.28;
  //println("angulo calculado: "+ (360*tobj.getAngle())/6.28 );
  //println("porcentagem rot: "+ ((100*ang)/360) );
  
  ang_before = current_ang;
  current_ang = ang;
  float diff = ang_before - current_ang;
  float abs_diff = abs(diff);
  
  if( diff != 0 ){
    println("=======================================================");
    
    if( current_ang > ang_before ){
      //TUDO == mudar a fórmula da diferença
      //diff = ang_before - current_ang;
      //abs_diff = abs(diff);
      if( ang_before < 15 && current_ang > 350 ){
        println( "    rot decrescimento + : Volta completa" );
        float from_before_to_zero = ang_before;
        float from_360_to_current = 360 - current_ang;
        diff = from_360_to_current + from_before_to_zero;
        abs_diff = abs(diff);
      }else{
        println( "    rot crescimento : before greater" );
      }
    }
    else if( current_ang < ang_before ){
      //TODO == mudar a formula da diferença
      //diff = current_ang - ang_before;
      //abs_diff = abs(diff);
      
      //trata o decrescimento vindo do crescimento
      if( ang_before > 340 && current_ang < 15 ){
        println( "    rot crescimento + : Volta completa" );
        float from_before_to_360 = 360 - ang_before;
        float from_zero_to_current = current_ang;
        diff = from_before_to_360 + from_zero_to_current;
        abs_diff = abs(diff);
      }else{
        println( "    rot decrescimento : before greater" );
      }
    }
    
    target_value += (diff * -1);
    
    //trata a amplitude 0.0 -> 1.0
    if( target_value <= 0 ){
      amp = 0.0;
    }
    else if (target_value >= 360){
      amp = 1.0;
    }
    else{
      amp = target_value/360;
    }
    
    //trata frequencia
    freq = target_value;
    
    //println("    angulo do reactivision: "+ tobj.getAngle());
    //println("    angulo graus: "+ (360*tobj.getAngle())/6.28 );
    //println("    porcentagem rot: "+ ((100*ang)/360) + "%" );
    //println("    diferença: " + diff + "  -  abs_diff: " + abs_diff );
    //println("    current_ang: "+ current_ang +"  -  ang_before: "+ang_before);
    
    
    
    /*
    if( ( ang_before > 340 || ang_before < 20) && abs_diff > 300 ){
      //um giro foi completado
      println("Giro completado");
      if( diff > 0 ){
        //soma valor
        println("  soma valor apos giro");
        }
      else if( diff < 0 ) {
        //subtrai valor
        println("  subtrai valor após giro");
      }
    }
    else{
      if( diff > 0 ){
        //soma valor
        println("  soma valor");
        }
      else if( diff < 0 ){
        //subtrai valor
        println("  subtrai valor");
      }
    }//*/
    
    /*
    if( ang_before > 350 ){
      if( ang_degree < 350 ){
        diff = 360 - diff;
      }
    }
    else if( ang_before < 10 ){
      if( ang_degree > 350 ){
        diff = 360 + diff;
      }
    }
      target_value += diff;
    //*/
    
    println( "value: " + target_value );
    
  }//if diff != 0
  
  //println("rot acumuladas: "+full_rot);
  //
}

// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  //println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  //println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()+" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel() );
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  //println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

// called after each message bundle
// representing the end of an image frame
void refresh(TuioTime bundleTime) { 
  redraw();
}
