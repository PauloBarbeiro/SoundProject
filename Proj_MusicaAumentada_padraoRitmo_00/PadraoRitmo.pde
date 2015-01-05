class PadraoRitmo{
  //cada padrão possuirá uma série de marcas: classe Mark
  // cada uma com uma propriedade de posição, duração, escala
  Mark[] marcas = new Mark[4];
  //SinOsc sine;
  
  PadraoRitmo(){
    float pos = metronomo/4;   
    marcas[0] = new Mark(0      , n_do, pos*0.8);
    marcas[1] = new Mark(pos    , n_re, pos*0.8);
    marcas[2] = new Mark((pos*2), n_mi, pos*0.8);
    marcas[3] = new Mark((pos*3), n_fa, pos*0.8);
    
    //this.sine = new SinOsc(this);
  }//construct

  void run(){
    for(int i=0 ; i<marcas.length ; i++){
      marcas[i].run(metro.current_tick /*, this.sine*/);
    }
  }

}//class
