module main();
integer a,b;
  initial 
    begin
      a=2;
    //   b=0;
      b=7+a;
      $display(b);
      $finish ;
    end
endmodule