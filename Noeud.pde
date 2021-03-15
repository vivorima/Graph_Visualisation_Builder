class Noeud implements Comparable
{
    
    public int v;
    float dis;
    ArrayList<Noeud> voisins;
    float x,y;
    int pos; // the node position in the graph
    
    public Noeud(int v,int pos)
    {
      this.v = v;
      this.pos = pos;
      this.voisins = new ArrayList();
    }
    
    public Noeud(int v,int pos,float x,float y)
    {
      this.v = v;
      this.pos = pos;
      this.x = x;
      this.y = y;
      this.voisins = new ArrayList();
    }
    
    public void AddVoisin(Noeud node){
      this.voisins.add(node);
      node.getVoisins().add(this);
    }
    
    public ArrayList<Noeud> getVoisins(){
      return this.voisins;
    }
    
    // draw the node
      void show(int offset,int distance,int y,int diam){ 
        fill(150);
        stroke(0,0,0);
        ellipse(offset+pos*distance, y,diam, diam);
        textSize(distance/3);
        fill(0, 102, 153);
        text("V"+v, offset+pos*distance-distance/6, y+diam*2); 
      }
    
    
    void updatePOS(ArrayList<Noeud> Tab) {
        this.pos=Tab.indexOf(this);
      }
    
    @Override
    public String toString(){
      String s = "V"+str(v);
      
      if(this.voisins!=null){
        s = s+": [";
        for (int i = 0; i <  this.voisins.size(); i++) {
          s = s + " V"+ str(this.voisins.get(i).v)+",";
        }
        s = s+"]-----" + str(dis);
      }else s = s+": aucun voisin.";
      return s;
}
  
  @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }

        if (obj.getClass() != this.getClass()) {
            return false;
        }

        final Noeud other = (Noeud) obj;
        if (this.v!=other.v) {
            return false;
        }

        return true;
    }
    
    public float distance(){
      float d = (float)this.pos;
      
      for(int i=0; i<this.voisins.size();i++){
          d = d+ (float) this.voisins.get(i).pos;
      }
      
      this.dis= d/(this.voisins.size()+1);
      return d/(this.voisins.size()+1);
      
    }
    
    @Override
    public int compareTo(Object o) {
        Float that=new Float(((Noeud)o).dis);
        Float t = new Float(this.dis);
        return t.compareTo(that);
    }
}
