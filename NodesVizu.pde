NodeSystem ns,ns_plus; // the graph of nodes
int nb_node= 0;// number of nodes


Noeud rename=null;
int space=145;
int offset = 40;
int distance =60;
int diam=30;  
int nb=0;
boolean input= true;
int  pressed = 0;
Noeud n1,n2;

//CREATION DES TABLEAUX
ArrayList<ArrayList<Noeud> > generalList = new ArrayList<ArrayList<Noeud> >(10); //max 10 itérations
ArrayList<Noeud> T = new ArrayList<Noeud>();
ArrayList<Noeud> T_plus = new ArrayList<Noeud>();



void setup(){
      background(255,5);  // bg for startup
      size(800,800);
      
       
       T.add(new Noeud(0,0));
        T.add(new Noeud(2,1));
        T.add(new Noeud(4,2));
        T.add(new Noeud(5,3));
        T.add(new Noeud(3,4));
        T.add(new Noeud(1,5));
        
        nb=T.size();
        
        T.get(0).AddVoisin(T.get(5));
        T.get(0).AddVoisin(T.get(1));
        T.get(5).AddVoisin(T.get(1));
        T.get(5).AddVoisin(T.get(4));
        T.get(1).AddVoisin(T.get(2));
        T.get(1).AddVoisin(T.get(3));
        T.get(1).AddVoisin(T.get(3));
        
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
          
  
  nb_node=T.size();
  //generalList.add(new ArrayList<Noeud>(T));
  print("\n",T);
  
       
        int itr =0;
        //tant que T!=T'
        while(!T.equals(T_plus)  && itr<nb_node){
          
          //si c'est pas le début alors T<-T'
          if(T_plus.size()!=0) {
            //sauvegarde du T' dans T
            java.util.Collections.copy(T,T_plus);
            //si c'est le début T est le tableau initial
          }
          //init du T'
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
          print("\n",itr,T_plus);
           
          //generalList.add(new ArrayList<Noeud>(T_plus));
          itr++;

      }
      
}


//TO RENAME THE ELEMENTS
void keyPressed(){
  if(input && rename!=null){

      
    if (key == '0' ||key == '1' || key == '2' || key == '3' ||key == '4' ||key == '5' || key == '6' || key == '7' || key == '8' || key == '9')
    {
      
        rename.v=key-48;
        textSize(16);
        fill(0, 204, 106);
        text("v"+rename.v, rename.x+diam/2, rename.y-diam/2); 
        
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
              fill(26, 0, 123);
              stroke(0,0,0);
              ellipse(mouseX, mouseY,diam, diam);
              textSize(16);
              text(n.v, mouseX-diam/2, mouseY-diam/2); 
              
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
          }else 
          erreur("waiting to complete link");
        }
        //attente du deuxieme node
        else if(pressed==2)  {
          
           n2 = getClosestNode(mouseX,mouseY); 
          
          if(n2==null){
            erreur("no node found at this location");
            //annuler le lien 
            pressed = 0;
          }else if(n1==n2){
            erreur("link with same node, try over");
            //annuler le lien 
            pressed = 0;
          }
          else
          {
            
            //ajouter la relation de voisinage
             n1.AddVoisin(n2);
            //dessiner le lien
            stroke(150);
            line(n1.x, n1.y, n2.x, n2.y);
            //initialiser 
            pressed = 0; 
            erreur("link completed");
          }
        }
        
        rename=null;
        
      }       
      
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
}


void draw(){
     
      /*if(input){
        //button
        fill(26, 0, 123);
        rect(250,700,300,50);
        //text button
        textSize(25);
        textAlign(CENTER);
        fill(255);
        text("Meilleure Visualisation",400,735);
      }else{ */
        
        update();
        if(generalList.size()>5){
          
          diam=20;
          
          for(int itr=0;itr<generalList.size();itr++){
            
                T_plus= generalList.get(itr);
                //Dessiner le graphe T
                if(itr>4)
                {
                  
                  offset = (800-(distance*(nb))); //second part
                  ns_plus = new NodeSystem(T_plus,(itr-4)*space);
                  textSize(18);
                  fill(26, 0, 123);
                  text("Itr "+itr, offset, (itr-4)*space-60); 
                  ns_plus.display(offset,distance,diam);
                }
                else{
                    
                  distance = (700/(nb))/2;
                  offset = (700-(distance*(nb-1))*2)/2; //first part
                  
                  ns_plus = new NodeSystem(T_plus,(itr+1)*space);
                  textSize(18);
                  fill(26, 0, 123);
                  text("Itr "+itr, offset, (itr+1)*space-60); 
                  ns_plus.display(offset,distance,diam);
                }
            
          }
          
        }
        else{
          
          
        distance = (700/(nb));
        offset = (800-distance*(nb-1))/2; //middle
        for(int itr=0;itr<generalList.size();itr++)
        {
              T_plus= generalList.get(itr);
              ns_plus = new NodeSystem(T_plus,(itr+1)*space);
              textSize(18);
              fill(26, 0, 123);
              text("Itr "+itr, offset, (itr+1)*space-60); 
              ns_plus.display(offset,distance,diam);
        }
        
          
          
        }
        
        noLoop();
          
        
 //     }


}
