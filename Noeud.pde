class Noeud implements Comparable
{
    
    public int v;
    float dis;
    ArrayList<Noeud> voisins;
    float x,y;
    
    public Noeud(Noeud n)
    {
      this.v = n.v;
      this.voisins = new ArrayList(n.voisins);
      this.x=n.x;
      this.y=n.y;
      this.dis=n.dis;
    }
    
    public Noeud(int v)
    {
      this.v = v;
      this.voisins = new ArrayList();
    }
    
    public Noeud(int v,float x,float y)
    {
      this.v = v;
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
      void show(int offset,int distance,int y,int diam, int pos){ 
        strokeWeight(2);
        stroke(130, 57, 49);
        fill(170, 93, 87);
        ellipse(offset+pos*distance, y,diam, diam);
        textSize(0.65*diam);
        textAlign(CENTER);
        text("v"+v, offset+pos*distance, y+1.2*diam); 
        text(String.format("%.1f", this.dis), offset+pos*distance, y+1.9*diam);   
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
        if (this.x!=other.x || this.y!=other.y || this.v!=other.v) {
            return false;
        }

        return true;
    }
    
    public float distance(ArrayList<Noeud> nodes){
      float d = (float)nodes.indexOf(this);
      
      for(int i=0; i<this.voisins.size();i++){
          d = d+(float) nodes.indexOf(this.voisins.get(i));
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
