class Mark{

  float posicao = 0;
  float escala  = 0;
  float duracao = 0;
  float posicao_visual_y = 0;
  float indice_de_alteracao = 5;
  
  Mark(float pos, float esc, float dur){
    //float pos = metronomo/4;
    this.posicao = (metronomo/4)*pos;
    this.escala  = esc;
    this.duracao = dur;
    println("posicao: "+ this.posicao +"  escala: "+ this.escala +"  duracao: "+ this.duracao);
  }
  
  void run(int tick /*, SinOsc sine*/){
    if( tick > this.posicao && tick < (this.posicao+this.duracao) ){
      //play note
      //println("play note: "+this.posicao);
      sine.freq(this.escala);
      //sine.amp(amp);
    }
    else{
      //not play note
      //println("stop note: "+this.posicao);
      //sine.amp(0);
    }
  }
  
  void changeEscala(float value){
    //println("MARCA changeEscala");
    int v = int(value);
    
    if( v > 0 ){
      int level = v/10;
      //println(level);
      //level = level+2;//isso é necessário, se houver a necessidade de não aproximar o intrum. do centro.
      if( level > -1 && level < 7 ){
        println( "final Scale : "+ full_scale[level] );
        this.posicao_visual_y = indice_de_alteracao * level;
        println(" pos visual: "+this.posicao_visual_y);
      }
    }
    else{
      
    }
  }//change
  
}
