class Instrumento{
  
  int id;
  float screen_pos_x;
  float screen_pos_y;
  PVector pos; 
  float freq;
  float amp;
  float pan;
  
  PadraoRitmo padrao;
  
  Instrumento(int id){
  
    this.id = id;
    this.freq = n_do;
    this.amp = 0.5;
    this.pan = 0;
    this.pos = new PVector(0,0);
  }
  
  void run(){
    this.display();
  }
  
  void display(){
    ellipseMode(CENTER);
    ellipse(this.screen_pos_x, this.screen_pos_y, 10, 10);
  }

  void updateTuio(TuioObject tobj){
  
    if(tobj.getSymbolID() == this.id){
      float ang = (360*tobj.getAngle())/6.28;
      ang_before = current_ang;
      current_ang = ang;
      float diff = ang_before - current_ang;
      float abs_diff = abs(diff);
      //println("x: "+tobj.getX()+"   y: "+tobj.getY());
      this.screen_pos_x = width*tobj.getX();
      this.screen_pos_y = height-(height*tobj.getY());
      this.pos.x = this.screen_pos_x;
      this.pos.y = this.screen_pos_y;
    }
    
  }

}
