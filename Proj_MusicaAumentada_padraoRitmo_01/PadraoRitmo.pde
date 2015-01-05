class PadraoRitmo{
  
  int tuio_ID;
  float screen_pos_x;
  float screen_pos_y;
  
  //cada padrão possuirá uma série de marcas: classe Mark
  // cada uma com uma propriedade de posição, duração, escala
  Mark[] marcas = new Mark[4];
  //SinOsc sine;
  
  PadraoRitmo(int id){
    float pos = metronomo/4;   
    marcas[0] = new Mark(0 , n_do, pos*0.8);
    marcas[1] = new Mark(1 , n_re, pos*0.8);
    marcas[2] = new Mark(2 , n_mi, pos*0.8);
    marcas[3] = new Mark(3 , n_fa, pos*0.8);
    
    this.tuio_ID = id;
    //this.sine = new SinOsc(this);
  }//construct

  void run(){
    for(int i=0 ; i<marcas.length ; i++){
      marcas[i].run(metro.current_tick /*, this.sine*/);
    }
    this.display();
  }

  void updateTuio(TuioObject tobj){
  
    if(tobj.getSymbolID() == this.tuio_ID){
      float ang = (360*tobj.getAngle())/6.28;
      ang_before = current_ang;
      current_ang = ang;
      float diff = ang_before - current_ang;
      float abs_diff = abs(diff);
      //println("x: "+tobj.getX()+"   y: "+tobj.getY());
      this.screen_pos_x = width*tobj.getX();
      this.screen_pos_y = height-(height*tobj.getY());
    }
    
  }

  void display(){
    noStroke();
    fill(200);
    //rectMode(CENTER);
    rect(this.screen_pos_x, this.screen_pos_y, pr_width, pr_height);
    fill(100);
    //println( "tick: "+ );
    for(int i=0 ; i<marcas.length ; i++){
      //marcas[i].run(metro.current_tick /*, this.sine*/);
      rect( this.screen_pos_x+((marcas[i].posicao/1000)*pr_width),
            this.screen_pos_y,
            (marcas[i].duracao/metronomo)*pr_width,
            pr_height );
    }
    
    strokeWeight(1);
    stroke(255);
    
    println("=====================================================================");
    //println(" Larg: "+pr_width+" percent: "+metro.percent_tick+ "  current: "+metro.current_tick);
    float float_tick = metro.current_tick;
    float float_metronomo = metronomo;
    println(" cicle percent in width: "+ float_tick/float_metronomo);
    println( "largura/percent: "+ (pr_width/metro.percent_tick) );
    //println( "position in bar: "+this.screen_pos_x + (pr_width/metro.percent_tick) );
    
    line(  this.screen_pos_x + (pr_width*(float_tick/float_metronomo)), this.screen_pos_y-10,
           this.screen_pos_x + (pr_width*(float_tick/float_metronomo)), this.screen_pos_y+10);
    
    
  }

}//class
