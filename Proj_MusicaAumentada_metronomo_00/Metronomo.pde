class Metronomo{
  
  int start_time = 0;
  float radius = 0;
  float percent_tick = 0.0;
  
  Metronomo(){
  }
  
  float calcula(int tempo){
    //println( "     calc tempo :" + tempo );
    //println( "     calc height:" + height );
    //println( "     calc start :" + this.start_time );
    //println( "     calc metron:" + metronomo );
    //println( "     calc RESULT:" + ( height*tempo )/( this.start_time + metronomo ) );
    //println( "     calc NEW RESULT:" + ( height*(tempo-previous_tempo) )/( metronomo ) );
    
    return ( height*(tempo-previous_tempo) )/( metronomo );
  }
  
  void display(){
    //println(this.percent_tick);
    stroke(255,100);
    strokeWeight(10);
    ellipse(width/2, height/2, this.radius, this.radius);
  }
  
  void trigger(){
    this.radius = 0;
    this.start_time = millis();
    //println("Metro trigger: "+this.percent_tick);
  }
  
  void run(){
    //this.percent_tick = ( millis()-previous_tempo )/metronomo;
    this.radius = this.calcula( millis() );
    //println( "     ----- "+this.radius );
    this.display();
  }

}//class
