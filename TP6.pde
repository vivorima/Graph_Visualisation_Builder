NodeSystem ns,ns_plus; // the graph of nodes
int nb_node= 6;// number of nodes
       
       //CREATION------------------------------------------------------------------------------
        ArrayList<Noeud> T = new ArrayList<Noeud>();
        ArrayList<Noeud> T_plus = new ArrayList<Noeud>();



void setup(){
      background(255,5);  // bg for startup
      size(400,800);
      
       
      // frameRate(1);
       smooth(); // make it smooth
        // initalise all the nodes
        // if you put the init into the draw it calcs every loop new nodes

        
        T.add(new Noeud(0,0));
        T.add(new Noeud(2,1));
        T.add(new Noeud(4,2));
        T.add(new Noeud(5,3));
        T.add(new Noeud(3,4));
        T.add(new Noeud(1,5));
        
        T.get(0).AddVoisin(T.get(5));
        T.get(0).AddVoisin(T.get(1));
        T.get(5).AddVoisin(T.get(1));
        T.get(5).AddVoisin(T.get(4));
        T.get(1).AddVoisin(T.get(2));
        T.get(1).AddVoisin(T.get(3));
        
        
}// end of setup



void update(){
      
          //ns.display();
          
              
        //----------------------------------------------------------------------------------------

        int itr =0;
        while(!T.equals(T_plus)  && itr<nb_node){
          
          
          if(T_plus.size()!=0) {
            java.util.Collections.copy(T,T_plus);
          }
          T_plus = new ArrayList<Noeud>();
          
          
           
          //calculer les distance et inserer dans 
          for (int i = 0; i < T.size(); i++) {
            //calcul la distance
            T.get(i).updatePOS(T);
            T.get(i).distance();
            T_plus.add(T.get(i));
          }
          
          
            java.util.Collections.sort(T_plus);
          
        
          print("\n\nT",itr,"///////////////////////////////////////////////\n");
          for (int i = 0; i < T.size(); i++) {
            print(T.get(i),"\n");
          }
          print("T",itr+1,"----------------------------------\n");
          for (int i = 0; i < T_plus.size(); i++) {
            print(T_plus.get(i),"\n");
          }
          
          itr++;
          ns_plus = new NodeSystem(T_plus,135*itr);
          
        
      ns_plus.display();

      }
  
}



void draw(){
      // write a rect in the size of the sketch for smooth background clear
      //noStroke();
      //fill(255,23);
      //rect(0,0,width,height);
    // run the node system
    update();

    //saveFrame("images/nodes-####.tif");
    //noLoop();
}



/*
V0: 2
V2: 2.2 
V4: 1.5 
V5: 2
V3: 4.5 
V1: 2.5 

V4: 1.5 
V0: 2.6666667 
V5: 2.5 
V2: 2.0 
V1: 3.25 
V3: 4.5 

----------------------------------
V4: 0.5 
V2: 2.0 
V5: 1.5 
V0: 2.6666667 
V1: 3.25 
V3: 4.5 



V4: 1.0 
V5: 1.5 
V2: 2.0 
V0: 3.0 
V1: 3.5 
V3: 4.5 


V4: 1.0 
V5: 1.5 
V2: 2.0 
V0: 3.0 
V1: 3.5 
V3: 4.5

pour la condition d'arret 
 peut trouver d'autres valeurs qui préservent l'ordre du tableau ?

*/
      //insert into an already sorted list 
      /*if(T_plus.size()==0)  T_plus.add(T.get(i));
      else{
        for (int j = 0; j < T_plus.size(); j++) {
            if (T_plus.get(j).dis < temp) continue;
            if (T_plus.get(j).dis == temp) {T_plus.add(j+1, T.get(i));break;}
            if (T_plus.get(j).dis > temp) {T_plus.add(j, T.get(i));break;}
            T_plus.add(j+1, T.get(i));
            break;
        }
      }*/
