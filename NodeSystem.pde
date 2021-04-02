class NodeSystem{

ArrayList <Noeud> nodes; // a list of nodes
int y;
int nb_connections;

  // constructor 
  NodeSystem(ArrayList <Noeud> nodes,int y){
    this.nodes = nodes;
    this.y = y;
    this.nb_connections = 0;

}


// calculate the connections and draw the lines
void DrawConnections(Noeud n,int offset,int distance,int y,int diam){
      
      int num = n.getVoisins().size(); // number of connections
      int  v1 = n.pos; // position of the node
      
      for(int i = 0; i < num; i ++){
          int  v2 =  n.getVoisins().get(i).pos; // every other voisin
          
          //just a verification in case of error and we add the same node as voisin
          if((java. lang. Math. abs(v1-v2) >= 1)){
           
            stroke(0,random(100, 255), random(100, 255), random(100, 255));
            noFill();
            arc(offset+distance*(v1+v2)/2,y,distance*(java. lang. Math. abs(v1-v2)), diam+(java. lang. Math. abs(v1-v2))*28,-PI,0, OPEN);
            
            nb_connections++;
          }
      }
}
      
  // display the nodes and draw the connections
void display(int offset,int distance,int diam){

        
       Noeud n = null;// keep it clear
      for(int i = 0; i < nodes.size(); i++){
        n = nodes.get(i);
        // call the functions of no);
       DrawConnections(n,offset,distance,y,diam);  
   }
   
   for(int i = 0; i < nodes.size(); i++){
        n = nodes.get(i);
        n.show(offset,distance,y,diam);// display
   }
    
    
} // end display
      
      
    }
