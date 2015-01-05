class Mark{

  float posicao = 0;
  float escala  = 0;
  float duracao = 0;
  
  Mark(float pos, float esc, float dur){
    this.posicao = pos;
    this.escala  = esc;
    this.duracao = dur;
    println("posicao: "+ this.posicao +"  escala: "+ this.escala +"  duracao: "+ this.duracao);
  }
  
  void run(int tick /*, SinOsc sine*/){
    if( tick > this.posicao && tick < (this.posicao+this.duracao) ){
      //play note
      println("play note: "+this.posicao);
      sine.freq(this.escala);
      sine.amp(amp);
    }
    else{
      //not play note
      println("stop note: "+this.posicao);
      //sine.amp(0);
    }
  }
  
}
