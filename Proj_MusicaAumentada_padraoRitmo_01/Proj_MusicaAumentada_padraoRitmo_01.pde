/*
This is a sine-wave oscillator. The method .play() starts the oscillator. There
are several setters like .amp(), .freq(), .pan() and .add(). If you want to set all of them at
the same time use .set(float freq, float amp, float add, float pan)
*/

import processing.sound.*;
import TUIO.*;

SinOsc sine;
TuioProcessing tuioClient;

Metronomo metro;

//Padroes ritmicos
PadraoRitmo pr1;
//dimensão dos padroes ritmicos na tela (width/height) 
int pr_width = 40;
int pr_height = 5;


//ferencias de notas para Osciladores =======================================
float n_do =261.6;
  float n_do_su=278;
float n_re =294;
float n_mi =330;
float n_fa =394;
float n_sol=392;
float n_la =440;
float n_si =495;

//valor do intervalo de repetição = marcador id 0 ===========================
// intervalo em milisegundos
int metronomo = 1000;
int current_tempo = 0;
int previous_tempo = 0;
//A repesentação pode ser um circulo que cresce do centro para as bordas.
//   no momento do tempo o circulo 'nasce', e chega ao limite da tela, no momento de anterior ao próximo tempo



float freq=400.0;//400
float amp=0.5;//0.5
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
    size(640, 480);
    background(0);
    
    // Create and start the sine oscillator.
    sine = new SinOsc(this);
    sine.amp(amp);
    sine.freq(freq);
    sine.pan(0);
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
    
    metro = new Metronomo();
    pr1 = new PadraoRitmo(5);
}

void draw() {
    
  // Map mouseY from 0.0 to 1.0 for amplitude
  //amp=map(mouseY, 0, height, 1.0, 0.0);
  //sine.amp(amp);
  //println( "Amplitude: "+ amp );
  //sine.amp(amp);
  
  // Map mouseX from 20Hz to 1000Hz for frequency  
  //freq=map(mouseX, 0, width, 80.0, 1000.0);
  //sine.freq(freq);
  
  // Map mouseX from -1.0 to 1.0 for left to right 
  //pos=map(mouseX, 0, width, -1.0, 1.0);
  //sine.pan(0);
  //sine.play();
  //base
  ellipseMode(CENTER);
  fill(53,47,108);
  noStroke();
  ellipse(width/2, height/2, height, height);
  //metronomo
  if( (millis() - previous_tempo) >= metronomo ){
    //println("TEMPO to play   "+metronomo);
    metro.trigger();
    
    
    previous_tempo = millis();
  }
  
  metro.run();
  pr1.run();
  
  
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
  //println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  //println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" angle: "+tobj.getAngle()+" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());

  pr1.updateTuio(tobj);

  //valores básicos
  float ang = (360*tobj.getAngle())/6.28;
  ang_before = current_ang;
  current_ang = ang;
  float diff = ang_before - current_ang;
  float abs_diff = abs(diff);

  //metronomo
  if(tobj.getSymbolID()==0){
    if( diff != 0 ){
      //println("=======================================================");
      if( current_ang > ang_before ){
        //TUDO == mudar a fórmula da diferença
        //diff = ang_before - current_ang;
        //abs_diff = abs(diff);
        if( ang_before < 15 && current_ang > 350 ){
          //println( "    rot decrescimento + : Volta completa" );
          float from_before_to_zero = ang_before;
          float from_360_to_current = 360 - current_ang;
          diff = from_360_to_current + from_before_to_zero;
          abs_diff = abs(diff);
        }
        //else{
        //  println( "    rot crescimento : before greater" );
        //}
      }
      else if( current_ang < ang_before ){
        //TODO == mudar a formula da diferença
        //diff = current_ang - ang_before;
        //abs_diff = abs(diff);
      
        //trata o decrescimento vindo do crescimento
        if( ang_before > 340 && current_ang < 15 ){
          //println( "    rot crescimento + : Volta completa" );
          float from_before_to_360 = 360 - ang_before;
          float from_zero_to_current = current_ang;
          diff = from_before_to_360 + from_zero_to_current;
          abs_diff = abs(diff);
        }
        //else{
        //  println( "    rot decrescimento : before greater" );
        //}
      }
    
    //target_value += (diff * -1);
    metronomo += (diff * -1);
    if( metronomo <= 0 ) metronomo = 0; 
    println("METRONOMO: "+metronomo);
    }//diff != 0
  }//metronomo id
  
  
  
}//callback do tuio update

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
