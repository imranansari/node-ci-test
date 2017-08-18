# node ci test module

Docker based CI for node


<img src='https://g.gravizo.com/svg?
 digraph G {
   main -> parse -> execute;
   main -> init;
   main -> cleanup;
   execute -> make_string;
   execute -> printf
   init -> make_string;
   main -> printf;
   execute -> compare;
 }
'/>

<a href="https://olivermak.es/">
  <img src="https://olivermak.es/resources/icons/favicon144.svg" width="100%" height="144">
</a>
