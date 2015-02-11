
import TUIO.*;
import hypermedia.net.*;

TuioProcessing tuioClient;
UDP udp;

float current_ang;

void setup() {
    size(100, 100);
    background(0);
    
    //TUIO
    frameRate(30);

    // we create an instance of the TuioProcessing client
    // since we add "this" class as an argument the TuioProcessing class expects
    // an implementation of the TUIO callback methods (see below)
    tuioClient  = new TuioProcessing(this);    
    
    //UDP
    udp = new UDP(this, 6000); //this is for incomming messages
    udp.log(true);
    udp.listen( false );
}

void draw() {
    
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
  println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" angle: "+tobj.getAngle()+" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());

  
  //valores básicos
  float ang = (360*tobj.getAngle())/6.28;
  float ang_before = current_ang;
  float current_ang = ang;
  float diff = ang_before - current_ang;
  float abs_diff = abs(diff);

  String message = str(tobj.getSymbolID())+"#"+str(tobj.getX())+"#"+str(tobj.getY())+"#"+str(tobj.getAngle())+"#"+str(ang);//+"#"+str(diff)+"#"+str(abs_diff);
  String[] ip = {"192.168.0.234", "192.168.0.104", "192.168.0.105", "192.168.0.107", "192.168.0.109"};
  int port = 9998;

  for(int i = 0; i<ip.length; i++){
    udp.send( message, ip[i], port );
  }
  
  //metronomo
  if(false){
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
    //metronomo += (diff * -1);
    //if( metronomo <= 0 ) metronomo = 0; 
    //println("METRONOMO: "+metronomo);
    }//diff != 0
  }//metronomo id */
  
  
  
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
