NodeSystem ns,ns_plus; // the graph of nodes
int nb_node= 6;// number of nodes
int offset = 40;
int distance =60;
int diam=30;  
int nb=0;
boolean input= true;
int  pressed = 0;
Noeud n1,n2;

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

        
       /* T.add(new Noeud(0,0));
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
        T.get(1).AddVoisin(T.get(3));*/
        
        
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
          
      textSize(18);
        fill(0, 0, 0);
        text("T"+itr, 40 , 135*itr-50); 
      ns_plus.display();

      }
  
}


//save mouse x w mouse y and then compare the mouse click with the coords-+diam of each ball x)
//and then wait for another click w draw the lines between the two objects


void mouseReleased() {
  if (input && mouseButton == LEFT) {
    
         if(mouseX>200 && mouseX <200+50 && mouseY>700 && mouseY <700+50){
          input=false;
         fill(0);
         //do stuff 
        }
        else if(input){
          
          Noeud n = new Noeud(nb,nb,mouseX,mouseY);
          T.add(n);
          nb++;
          fill(150);
          stroke(0,0,0);
          ellipse(mouseX, mouseY,diam, diam);
          textSize(distance/3);
          fill(0, 102, 153);
          text("V"+n.v, mouseX-diam/2, mouseY-diam); 
          
          print("\n\nT","///////////////////////////////////////////////\n");
            for (int i = 0; i < T.size(); i++) {
              print(T.get(i),"\n");
            }
        }
          
      } 
      if (input && mouseButton == RIGHT) {
        pressed += 1;
        
        if(pressed==1){
          //search for the closest node 
          n1 = getClosestNode(mouseX,mouseY); 
          if(n1==null){
            print("\nNo node found");
            pressed = 0;
          }
        }
        else if(pressed==2)  {
          
           n2 = getClosestNode(mouseX,mouseY); 
          
          if(n2==null){
            print("\nNo node found");
            pressed = 0;
          }else
          {
            //ajouter la relation de voisinage
             n1.AddVoisin(n2);
             
            line(n1.x, n1.y, n2.x, n2.y);
            print("\n\nT","///////////////////////////////////////////////\n");
            for (int i = 0; i < T.size(); i++) {
              print(T.get(i),"\n");
            }
            pressed = 0;  
          }
        }
        
      }
        
}



Noeud getClosestNode(float x,float y){
          int i = 0;
          while(i<T.size())
          {
            if(x < T.get(i).x+(diam/2) && x > T.get(i).x-(diam/2) && y < T.get(i).y+(diam/2) && y > T.get(i).y-(diam/2)){
            
              //found 
              return T.get(i);
            }
            else i++;
            
          }
          
      return null;
  
}


void draw(){
      
      if(input){
        rect(200,700,50,50);
        fill(255);
      }
       else update();
      
      // write a rect in the size of the sketch for smooth background clear
      //noStroke();
      //fill(255,23);
      //rect(0,0,width,height);
    // run the node system
    //update();

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
      
      
      
      
