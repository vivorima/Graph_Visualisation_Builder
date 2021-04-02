NodeSystem ns,ns_plus; // the graph of nodes
int nb_node= 6;// number of nodes


Noeud rename=null;
int offset = 40;
int distance =60;
int diam=30;  
int nb=0;
boolean input= true;
int  pressed = 0;
Noeud n1,n2;

//CREATION DES TABLEAUX
ArrayList<Noeud> T = new ArrayList<Noeud>();
ArrayList<Noeud> T_plus = new ArrayList<Noeud>();



void setup(){
      background(255,5);  // bg for startup
      size(800,800);
      
       /* nb=7;
       T.add(new Noeud(0,0));
        T.add(new Noeud(2,1));
        T.add(new Noeud(4,2));
        T.add(new Noeud(5,3));
        T.add(new Noeud(3,4));
        T.add(new Noeud(1,5));
        T.add(new Noeud(6,6));
        
        T.get(0).AddVoisin(T.get(5));
        T.get(0).AddVoisin(T.get(1));
        T.get(5).AddVoisin(T.get(1));
        T.get(5).AddVoisin(T.get(4));
        T.get(1).AddVoisin(T.get(2));
        T.get(1).AddVoisin(T.get(3));
      T.get(6).AddVoisin(T.get(3));
      T.get(6).AddVoisin(T.get(1));
      */
        
        
}// end of setup





//trouver le noeud near les coords x,y pour draw lines 
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


void update(){
          
  
        int itr =0;
        //tant que T!=T'
        while(!T.equals(T_plus)  && itr<nb_node){
          
          //si c'est pas le début T<-T', sinon on commence avec T initial
          if(T_plus.size()!=0) {
            java.util.Collections.copy(T,T_plus);
          }
          T_plus = new ArrayList<Noeud>();
         
           
          //calculer les distance et inserer dans T'
          for (int i = 0; i < T.size(); i++) { 
            //update la position des noeuds dans T
            T.get(i).updatePOS(T);
            //calcul la distance
            T.get(i).distance();
            //Ajouter dans T'
            T_plus.add(T.get(i));
          }
          
          //trier T'   
          java.util.Collections.sort(T_plus);
           
          
          //Dessiner le graphe T
          if(itr>4)
          {
            distance = distance/2;
            offset = offset/2;
          }
          else{
              
            ns_plus = new NodeSystem(T_plus,(itr+1)*135);
            textSize(18);
            fill(0, 0, 0);
            text("Itr:"+itr, offset/2 , (itr+1)*135); 
            ns_plus.display(offset,distance,diam);
          }
          
          itr++;

      }
  
}

void keyPressed(){
  if(input && rename!=null){

      
    if (key == '0' ||key == '1' || key == '2' || key == '3' ||key == '4' ||key == '5' || key == '6' || key == '7' || key == '8' || key == '9')
    {
        print(key);
        rename.v=key-48;
        textSize(12);
        fill(255, 0, 200);
        text("V"+rename.v, mouseX, mouseY+diam); 
        print(rename);
        rename = null;
        erreur("");
    }
    
  }
}

void mouseReleased() {
  
  erreur("");
  
   //CLICK BUTTON 
   if(mouseY>700 && mouseY <800){
            input=false;
            background(255,5);
  }
  
  //POUR DESSINER LES NOEUDS
  if (input && mouseButton == LEFT) {
          
           if(getClosestNode(mouseX,mouseY)==null){
             //create a node
              Noeud n = new Noeud(nb,nb,mouseX,mouseY);
              T.add(n);
              nb++;
              //draw the node
              fill(170, 93, 87);
              stroke(0,0,0);
              ellipse(mouseX, mouseY,diam, diam);
              textSize(16);
              fill(24, 24, 73);
              text(n.v, mouseX, mouseY-diam); 
              
              rename = null;
           }
           else {
             erreur("type on a number to rename this node"); 
             rename=getClosestNode(mouseX,mouseY);
           }
          
      } 
      
      //LIENS ENTRE LES NOEUDS
      if (input && mouseButton == RIGHT) {
        pressed += 1;
        //premier noeud
        if(pressed==1){
          
          //search for the closest node 
          n1 = getClosestNode(mouseX,mouseY); 
          
          if(n1==null){
            erreur("no node found at this location");
            //annuler le lien 
            pressed = 0;
          }
        }
        //attente du deuxieme node
        else if(pressed==2)  {
          
           n2 = getClosestNode(mouseX,mouseY); 
          
          if(n2==null){
            erreur("no node found at this location");
            //annuler le lien 
            pressed = 0;
          }else if(n1==n2){
            erreur("link with same node, try again");
            //annuler le lien 
            pressed = 0;
          }
          else
          {
            //ajouter la relation de voisinage
             n1.AddVoisin(n2);
            //dessiner le lien
            stroke(0);
            line(n1.x, n1.y, n2.x, n2.y);
            //initialiser 
            pressed = 0;  
          }
        }
        
        rename=null;
        
      }       
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  println(e);
}

//afficher une erreur 
void erreur(String msg){
  
            stroke(255,255,255);
            fill(255, 255, 255);
            rect(0,700,800,100);
            textSize(14);
            textAlign(CENTER);
            fill(255, 0, 1);
            text(msg,400,780); 
            print("\n",msg);
}


void draw(){
     
      if(input){
        //button
        fill(64, 64, 64);
        rect(250,700,300,50);
        //text button
        textSize(25);
        textAlign(CENTER);
        fill(51, 255, 155);
        text("Meilleure Visualisation",400,735);
      }else{ 
        //to center them in the middle 
        
        distance = 700/(nb);
        offset = (800-distance*(nb-1))/2;
        update();
      }


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
      
      
      
      
