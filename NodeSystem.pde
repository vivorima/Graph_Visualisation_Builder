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

// run the nodesystem
void run(){
 
  display();
  noLoop();
  
}

// calculate the connections and draw the lines
void DrawConnections(Noeud n,int offset,int distance,int y,int diam){
      
      int num = n.getVoisins().size(); // number of connections


      for(int i = 0; i < num; i ++){
          int  v1 = n.pos; // position of the refrence positoin
          int  v2 = nodes.get(i).pos; // every other node
          
          // now if the node already has some connections
          // make the diastance he can check higher
          if((java. lang. Math. abs(v1-v2) >= 1)){
           
            stroke(0,150, 102, 153);
            noFill();
            //line(20+30*v1 , 100,20+30*v2, 100); // draw the line
            arc(offset+distance*(v1+v2)/2,y,distance*(java. lang. Math. abs(v1-v2)), diam+(java. lang. Math. abs(v1-v2))*nb_connections*4,-PI,0, OPEN);
            nb_connections++;
          }
      }
}
      
  // display the nodes and draw the connections
void display(){

       Noeud n = null;// keep it clear
      for(int i = 0; i < nodes.size(); i++){
        n = nodes.get(i);
        // call the functions of no);

        int offset = 60;
        int distance =50;
        int diam=15;
      
        DrawConnections(n,offset,distance,y,diam);
        n.show(offset,distance,y,diam);// display
     }
    
    
} // end display
      
      
    }
