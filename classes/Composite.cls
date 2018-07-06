public class Composite {

    Public Interface Node{
        Node add(Node n);
        Boolean evaluate();
    }
    
    Public Abstract Class NodeAbstract implements Node{
        List<Node> children = new List<Node>();
        Boolean value;
        
        Public Virtual Node add(Node n){
            children.add(n);
            return this;
        }
        
        Abstract Boolean evaluate();         
    }
    
    Class ValueNode extends NodeAbstract{
        
        Public ValueNode(Boolean val){
            this.value = val;
        }
        
        Public Override Boolean evaluate(){
            return this.value;
        }
    }
    
    Class AndNode extends NodeAbstract{
        Public Override Boolean evaluate(){
            for(Node child: children){
            	if(!child.evaluate())  return False;
            }
            return True;
        }
    }

    Class OrNode extends NodeAbstract{
        Public Override Boolean evaluate(){
            for(Node child: children){
            	if(child.evaluate())  return True;
            }
            return False;
        }
    }
    
    Class NodeException extends System.Exception{}
    
    Class NotNode extends NodeAbstract{
        Public Override Boolean evaluate(){
        	return !children[0].evaluate();
        }
        
        Public Override Node add(Node n){
            if(children.size()!=0) throw new NodeException('Not Node cant accept more than one child');
            return super.add(n);
        } 
    }
   
    Public Static void doEvaluate(){
        // True AND False
        Boolean out = new AndNode()
            .add(new ValueNode(True))
            .add(new ValueNode(False))
            .evaluate();
        System.Assert(out == False);
        
        // ( True AND False ) OR True
        out =  new OrNode()
            	.add(
                    new AndNode()
                    .add(new ValueNode(True))
                    .add(new ValueNode(False))
                )
            	.add(new ValueNode(True))
            	.evaluate();
        System.Assert(out == True);
        
        // False OR NOT(True And False And True) And True
        out = new AndNode()   // False OR NOT(True And False And True) And True
            	.add(
                    new OrNode()  //  False OR NOT(True And False And True)
                    	.add(new ValueNode(False))
                    	.add(
                            new NotNode()   // NOT(True And False And True)
                            	.add(
                                    new AndNode()   // (True And False And True)
                                    	.add(new ValueNode(True))
                                    	.add(new ValueNode(False))
                                    	.add(new ValueNode(True))
                                )
                        )
                )
            	.add(new ValueNode(True))
            	.evaluate();
        System.Assert(out == True);
    }
}