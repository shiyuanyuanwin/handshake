module handshake #(parameter
    Depth = 10
)
(
    //Interface
    input           Clk         ,
    input           Rstn        ,

    //In interface
    input  [Depth-1:0] DataIn      ,
    input           DataInVld   ,
    output          DataInRdy   ,

    //Out interface
    output [Depth-1:0] DataOut     ,
    output          DataOutVld  ,
    output reg [Depth-1:0] data_out,
    input           DataOutRdy
);

//---------------------------------------------------------------------
wire data_in_rdy;
assign DataInRdy = DataInVld;

reg [Depth-1:0] data_out1;
assign DataOut = data_out1;

reg data_out_vld;
assign DataOutVld = data_out_vld;

reg DataInVld1,DataOutRdy1;
always @ ( posedge Clk )
begin
	DataInVld1 <= DataInVld;
	DataOutRdy1 <= DataOutRdy;
end

assign   data_in_rdy = DataOutRdy1 || ~data_out_vld;

always @( posedge Clk )
begin
    if( !Rstn )
    begin
        data_out <= 0;
    end
    else if( data_in_rdy && DataInVld1  )
    begin
        data_out <= DataIn ;
    end
end

always @( posedge Clk )
begin
    if( !Rstn )
    begin
        data_out1 <= 0;
    end
    else if( DataOutRdy1 && DataInVld1  )
    begin
        data_out1 <= data_out ;
    end
end

always @( posedge Clk )
begin
    if( !Rstn )
    begin
        data_out_vld <= 0;
    end
    else if( data_in_rdy )
    begin
        data_out_vld <= DataOutRdy1;
    end
end

endmodule