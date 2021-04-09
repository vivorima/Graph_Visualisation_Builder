int nb_node= 0;    // number of nodes
int nb_itr=0;     //number of iterations 

//CREATION DES TABLEAUX
Object[] generalList; //contenir les tabs intermédiares
ArrayList<Noeud> T = new ArrayList<Noeud>(); //tableau initial


//POUR L'interface
int space=165;     //entre les itérations
int offset = 40;  //décalage
int distance =60;  //entre les noeuds
int diam=30;  //noeud
int  pressed = 0;
boolean input= true;
Noeud n1,n2;
Noeud rename=null;


void setup(){
      background(255,5);  // bg for startup
      size(800,800);
      
      //EXEMPLE
    /*   
       T.add(new Noeud(0));
        T.add(new Noeud(2));
        T.add(new Noeud(4));
        T.add(new Noeud(5));
          //T.add(new Noeud(7));
        T.add(new Noeud(3));
        T.add(new Noeud(1));
          //T.add(new Noeud(6));
        
        
        T.get(0).AddVoisin(T.get(5));
        T.get(0).AddVoisin(T.get(1));
          //T.get(0).AddVoisin(T.get(6));
          //T.get(0).AddVoisin(T.get(7));
        T.get(5).AddVoisin(T.get(1));
        T.get(5).AddVoisin(T.get(4));
        T.get(1).AddVoisin(T.get(2));
        T.get(1).AddVoisin(T.get(3));

        
        nb_node=T.size();
        generalList = new Object[nb_node];
        generalList[0] = new ArrayList<Noeud>(T);
     */ 
        
}// end of setup


//ALGORITHME DE TRI
void ordonner(){
  
        int itr=1;
        
        //tant que T!=T'
        while(itr<nb_node){
          
              //calcul des distances dans T
             for(int i=0;i<nb_node;i++)
              {
                ((ArrayList<Noeud>)generalList[itr-1]).get(i).distance((ArrayList<Noeud>)generalList[itr-1]);
              }
            
            //T' <- T
            generalList[itr] = new ArrayList<Noeud>();
            for (int i = 0; i < nb_node; i++)
                       ((ArrayList<Noeud>)generalList[itr]).add(i,new Noeud(((ArrayList<Noeud>)generalList[itr-1]).get(i)));
                      
            
            //trier T' (en se basant sur la distance)
            java.util.Collections.sort(((ArrayList<Noeud>)generalList[itr]));
            
            //si T==T' je sors
            if(((ArrayList<Noeud>)generalList[itr-1]).equals((ArrayList<Noeud>)generalList[itr])) 
              break;
            
            itr++;
            
            //initialiser T de l'itr suivante pour pouvoir comparer T avec T'
            if(itr!=nb_node) generalList[itr] = new ArrayList<Noeud>();    
         }
         nb_itr=itr;
}




//TO RENAME THE NODES
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
  //initialiser affichage 
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
              Noeud n = new Noeud(nb_node,mouseX,mouseY);
              T.add(n);
              nb_node++;
              //draw the node
              strokeWeight(2);
              stroke(130, 57, 49);
              fill(170, 93, 87);
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
            strokeWeight(2);
            stroke(130, 57, 49);
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

void print_graph(){
    
   for(int i=0;i<nb_itr;i++)
    {
      
      if(((ArrayList<Noeud>)generalList[i])!=null ){
          print("\nitération: ",i);
        for(int k=0;k<nb_node;k++)
            print("\n",((ArrayList<Noeud>)generalList[i]).get(k));
      }
    }
}





void draw(){
  
  //pour créer le graphe
  if(input){
        //button
        strokeWeight(2);
        stroke(130, 57, 49);
        fill(170, 93, 87);
        rect(250,700,300,50);
        //text button
        textSize(25);
        textAlign(CENTER);
        fill(255);
        text("Meilleure Visualisation",400,735);
      }else{ 
                 
                noLoop(); //stop the loop
                //INITIALISATIONS
                nb_node=T.size();
                generalList = new Object[nb_node];
                generalList[0] = new ArrayList<Noeud>(T);
                //trier
                ordonner();
                
                //--------------------------------------DRAWING-------------------------------------------------
                        
                if(nb_itr>4){ //pour diviser l'affichage en deux 
                            
                                diam=20;
                                
                                for(int i=0;i<nb_itr;i++){
                                      //Dessiner le graphe T
                                      if(i>3)
                                      {
                                        //second part
                                        distance = (700/(nb_node))/2;
                                        offset = (800-(distance*(nb_node))); 
                                        NodeSystem ns_plus = new NodeSystem(new ArrayList<Noeud>((ArrayList<Noeud>)generalList[i]),(i+1-4)*space);
                                        textSize(18);
                                          fill(170, 93, 87);
                                        text("Itr "+i, offset, (i+1-4)*space-80); 
                                        ns_plus.display(offset,distance,diam);
                                      }
                                      else{
                                        //first part
                                        distance = (700/(nb_node))/2;
                                        offset = (800-(distance*(nb_node))*2)/2; ;
                                        
                                        NodeSystem ns_plus = new NodeSystem(new ArrayList<Noeud>((ArrayList<Noeud>)generalList[i]),(i+1)*space);
                                        textSize(18);
                                          fill(170, 93, 87);
                                        text("Itr "+i, offset, (i+1)*space-80); 
                                        ns_plus.display(offset,distance,diam);
                                      }
                                  
                                }
                            
                          }
                          else{
                            
                            
                                    distance = (700/(nb_node));
                                    offset = (800-distance*(nb_node-1))/2; //middle
                                    for(int i=0;i<nb_itr;i++)
                                      {
                                                                             
                                         NodeSystem ns_plus = new NodeSystem(new ArrayList<Noeud>((ArrayList<Noeud>)generalList[i]),(i+1)*space);
                                          textSize(18);
                                          fill(170, 93, 87);
                                          text("Itr "+i, offset, (i+1)*space-60); 
                                          ns_plus.display(offset,distance,diam);
                                      }
                           
                         }
     }
}
