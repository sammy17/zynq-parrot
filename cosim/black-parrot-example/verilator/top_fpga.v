
`timescale 1 ns / 1 ps

`include "bp_common_defines.svh"

	module top_fpga
	 import bp_common_pkg::*;
	 import bp_be_pkg::*;
	 import bp_me_pkg::*;
	 import bsg_noc_pkg::*;
	#(
		// Users to add parameters here
		parameter bp_params_e bp_params_p = e_bp_default_cfg
		`declare_bp_proc_params(bp_params_p)

		, localparam uce_mem_data_width_lp = `BSG_MAX(icache_fill_width_p, dcache_fill_width_p)
		`declare_bp_bedrock_mem_if_widths(paddr_width_p, uce_mem_data_width_lp, lce_id_width_p, lce_assoc_p, uce)
		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		, parameter integer C_S00_AXI_DATA_WIDTH	= 32
		, parameter integer C_S00_AXI_ADDR_WIDTH	= 32
		, parameter integer C_M00_AXI_DATA_WIDTH	= 64
		, parameter integer C_M00_AXI_ADDR_WIDTH	= 32
	)
	(
		// Users to add ports here

		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready,

		input wire  s01_axi_aclk,
		input wire  s01_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s01_axi_awaddr,
		input wire [2 : 0] s01_axi_awprot,
		input wire  s01_axi_awvalid,
		output wire  s01_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s01_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s01_axi_wstrb,
		input wire  s01_axi_wvalid,
		output wire  s01_axi_wready,
		output wire [1 : 0] s01_axi_bresp,
		output wire  s01_axi_bvalid,
		input wire  s01_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s01_axi_araddr,
		input wire [2 : 0] s01_axi_arprot,
		input wire  s01_axi_arvalid,
		output wire  s01_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s01_axi_rdata,
		output wire [1 : 0] s01_axi_rresp,
		output wire  s01_axi_rvalid,
		input wire  s01_axi_rready

		, input wire m00_axi_aclk
		, input wire m00_axi_aresetn
		, output wire [C_M00_AXI_ADDR_WIDTH-1:0]     m00_axi_awaddr
		, output wire                                m00_axi_awvalid
		, input wire                                 m00_axi_awready
		, output wire [5:0]                          m00_axi_awid
		, output wire [1:0]                          m00_axi_awlock
		, output wire [3:0]                          m00_axi_awcache
		, output wire [2:0]                          m00_axi_awprot
		, output wire [3:0]                          m00_axi_awlen
		, output wire [2:0]                          m00_axi_awsize
		, output wire [1:0]                          m00_axi_awburst
		, output wire [3:0]                          m00_axi_awqos

		, output wire [C_M00_AXI_DATA_WIDTH-1:0]     m00_axi_wdata
		, output wire                                m00_axi_wvalid
		, input wire                                 m00_axi_wready
		, output wire [5:0]                          m00_axi_wid
		, output wire                                m00_axi_wlast
		, output wire [(C_M00_AXI_DATA_WIDTH/8)-1:0] m00_axi_wstrb

		, input wire                                 m00_axi_bvalid
		, output wire                                m00_axi_bready
		, input wire [5:0]                           m00_axi_bid
		, input wire [1:0]                           m00_axi_bresp

		, output wire [C_M00_AXI_ADDR_WIDTH-1:0]     m00_axi_araddr
		, output wire                                m00_axi_arvalid
		, input wire                                 m00_axi_arready
		, output wire [5:0]                          m00_axi_arid
		, output wire [1:0]                          m00_axi_arlock
		, output wire [3:0]                          m00_axi_arcache
		, output wire [2:0]                          m00_axi_arprot
		, output wire [3:0]                          m00_axi_arlen
		, output wire [2:0]                          m00_axi_arsize
		, output wire [1:0]                          m00_axi_arburst
		, output wire [3:0]                          m00_axi_arqos

		, input wire [C_M00_AXI_DATA_WIDTH-1:0]      m00_axi_rdata
		, input wire                                 m00_axi_rvalid
		, output wire                                m00_axi_rready
		, input wire [5:0]                           m00_axi_rid
		, input wire                                 m00_axi_rlast
		, input wire [2:0]                           m00_axi_rresp
	);

	//TODO: Parameterize
	logic [2:0][C_S00_AXI_DATA_WIDTH-1:0] csr_data_lo;
	logic [C_S00_AXI_DATA_WIDTH-1:0] out_fifo_data_li, in_fifo_data_lo;
	logic out_fifo_v_li, out_fifo_ready_lo;
	logic in_fifo_v_lo, in_fifo_yumi_li;
	wire [2:0][C_S00_AXI_DATA_WIDTH-1:0] unused = csr_data_lo;

// Instantiation of Axi Bus Interface S00_AXI
	example_axi_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) example_axi_v1_0_S00_AXI_inst (
		.csr_data_o(csr_data_lo),

		.out_fifo_data_i(out_fifo_data_li),
		.out_fifo_v_i(out_fifo_v_li),
		.out_fifo_ready_o(out_fifo_ready_lo),

		.in_fifo_data_o(in_fifo_data_lo),
		.in_fifo_v_o(in_fifo_v_lo),
		.in_fifo_yumi_i(in_fifo_yumi_li),
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready)
	);

	// Add user logic here

	`declare_bp_bedrock_mem_if(paddr_width_p, uce_mem_data_width_lp, lce_id_width_p, lce_assoc_p, uce);
	bp_bedrock_uce_mem_msg_s io_cmd_lo, io_resp_li;
	logic io_cmd_v_lo, io_cmd_ready_and_li;
	logic io_resp_v_li, io_resp_yumi_lo;

	`declare_bsg_cache_dma_pkt_s(caddr_width_p);
	bsg_cache_dma_pkt_s dma_pkt_lo;
	logic dma_pkt_v_lo, dma_pkt_yumi_li;
	logic [l2_fill_width_p-1:0] dma_data_lo;
	logic dma_data_v_lo, dma_data_yumi_li;
	logic [l2_fill_width_p-1:0] dma_data_li;
	logic dma_data_v_li, dma_data_ready_and_lo;

	logic [C_S00_AXI_ADDR_WIDTH-1:0] waddr_translated_lo, raddr_translated_lo;
	always_comb
		begin
			if (s01_axi_awaddr < 32'hA0000000)
				waddr_translated_lo = s01_axi_awaddr - csr_data_lo[0];
			else
				waddr_translated_lo = s01_axi_awaddr - csr_data_lo[1];
		end

	always_comb
		begin
			if (s01_axi_araddr < 32'hA0000000)
				raddr_translated_lo = s01_axi_araddr - csr_data_lo[0];
			else
				raddr_translated_lo = s01_axi_araddr - csr_data_lo[1];
		end

	bp_to_axi_decoder
	 #(.bp_params_p(bp_params_p))
	 bp_out_data
		(.clk_i(s01_axi_aclk)
		 ,.reset_i(~s01_axi_aresetn)

		 ,.io_cmd_i(io_cmd_lo)
		 ,.io_cmd_v_i(io_cmd_v_lo)
		 ,.io_cmd_ready_and_o(io_cmd_ready_and_li)

		 ,.io_resp_o(io_resp_li)
		 ,.io_resp_v_o(io_resp_v_li)
		 ,.io_resp_yumi_i(io_resp_yumi_lo)

		 ,.data_o(out_fifo_data_li)
		 ,.v_o(out_fifo_v_li)
		 ,.ready_i(out_fifo_ready_lo)
		 );

	localparam axi_id_width_p = 6;
  localparam axi_addr_width_p = 33;
  localparam axi_data_width_p = 64;
  localparam axi_strb_width_p = axi_data_width_p >> 3;
  localparam axi_burst_len_p = 8;

	wire [32:0] axi_awaddr;
	wire [32:0] axi_araddr;
	assign m00_axi_awaddr = axi_awaddr - 32'h80000000 + csr_data_lo[2];
	assign m00_axi_araddr = axi_araddr - 32'h80000000 + csr_data_lo[2];

	bp_unicore_axi_sim
	 #(.bp_params_p(bp_params_p))
	 blackparrot
	 (.clk_i(s01_axi_aclk)
		,.reset_i(~s01_axi_aresetn)

		,.io_cmd_o(io_cmd_lo)
		,.io_cmd_v_o(io_cmd_v_lo)
		,.io_cmd_ready_and_i(io_cmd_ready_and_li)

		,.io_resp_i(io_resp_li)
		,.io_resp_v_i(io_resp_v_li)
		,.io_resp_yumi_o(io_resp_yumi_lo)

		,.s_axi_lite_awaddr_i(waddr_translated_lo)
    ,.s_axi_lite_awprot_i(s01_axi_awprot)
    ,.s_axi_lite_awvalid_i(s01_axi_awvalid)
    ,.s_axi_lite_awready_o(s01_axi_awready)

    ,.s_axi_lite_wdata_i(s01_axi_wdata)
    ,.s_axi_lite_wstrb_i(s01_axi_wstrb)
    ,.s_axi_lite_wvalid_i(s01_axi_wvalid)
    ,.s_axi_lite_wready_o(s01_axi_wready)

    ,.s_axi_lite_bresp_o(s01_axi_bresp)
    ,.s_axi_lite_bvalid_o(s01_axi_bvalid)
    ,.s_axi_lite_bready_i(s01_axi_bready)

    ,.s_axi_lite_araddr_i(raddr_translated_lo)
    ,.s_axi_lite_arprot_i(s01_axi_arprot)
    ,.s_axi_lite_arvalid_i(s01_axi_arvalid)
    ,.s_axi_lite_arready_o(s01_axi_arready)

    ,.s_axi_lite_rdata_o(s01_axi_rdata)
    ,.s_axi_lite_rresp_o(s01_axi_rresp)
    ,.s_axi_lite_rvalid_o(s01_axi_rvalid)
    ,.s_axi_lite_rready_i(s01_axi_rready)

		,.dma_pkt_o(dma_pkt_lo)
    ,.dma_pkt_v_o(dma_pkt_v_lo)
    ,.dma_pkt_yumi_i(dma_pkt_yumi_li)

    ,.dma_data_i(dma_data_li)
    ,.dma_data_v_i(dma_data_v_li)
    ,.dma_data_ready_and_o(dma_data_ready_and_lo)

    ,.dma_data_o(dma_data_lo)
    ,.dma_data_v_o(dma_data_v_lo)
    ,.dma_data_yumi_i(dma_data_yumi_li)
    );

	assign m00_axi_awqos = '0;
	assign m00_axi_arqos = '0;
	assign m00_axi_wid = m00_axi_awid;

	bsg_cache_to_axi
    #(.addr_width_p(caddr_width_p)
      ,.data_width_p(l2_fill_width_p)
      ,.block_size_in_words_p(l2_block_size_in_fill_p)
      ,.num_cache_p(1)
      ,.axi_id_width_p(axi_id_width_p)
      ,.axi_addr_width_p(axi_addr_width_p)
      ,.axi_data_width_p(axi_data_width_p)
      ,.axi_burst_len_p(axi_burst_len_p)
      )
   cache2axi
     (.clk_i(m00_axi_aclk)
      ,.reset_i(~m00_axi_aresetn)

      ,.dma_pkt_i(dma_pkt_lo)
      ,.dma_pkt_v_i(dma_pkt_v_lo)
      ,.dma_pkt_yumi_o(dma_pkt_yumi_li)

      ,.dma_data_o(dma_data_li)
      ,.dma_data_v_o(dma_data_v_li)
      ,.dma_data_ready_i(dma_data_ready_and_lo)

      ,.dma_data_i(dma_data_lo)
      ,.dma_data_v_i(dma_data_v_lo)
      ,.dma_data_yumi_o(dma_data_yumi_li)

      ,.axi_awid_o(m00_axi_awid)
      ,.axi_awaddr_o(axi_awaddr)
      ,.axi_awlen_o(m00_axi_awlen)
      ,.axi_awsize_o(m00_axi_awsize)
      ,.axi_awburst_o(m00_axi_awburst)
      ,.axi_awcache_o(m00_axi_awcache)
      ,.axi_awprot_o(m00_axi_awprot)
      ,.axi_awlock_o(m00_axi_awlock)
      ,.axi_awvalid_o(m00_axi_awvalid)
      ,.axi_awready_i(m00_axi_awready)

      ,.axi_wdata_o(m00_axi_wdata)
      ,.axi_wstrb_o(m00_axi_wstrb)
      ,.axi_wlast_o(m00_axi_wlast)
      ,.axi_wvalid_o(m00_axi_wvalid)
      ,.axi_wready_i(m00_axi_wready)

      ,.axi_bid_i(m00_axi_bid)
      ,.axi_bresp_i(m00_axi_bresp)
			,.axi_bvalid_i(m00_axi_bvalid)
      ,.axi_bready_o(m00_axi_bready)

      ,.axi_arid_o(m00_axi_arid)
      ,.axi_araddr_o(axi_araddr)
      ,.axi_arlen_o(m00_axi_arlen)
      ,.axi_arsize_o(m00_axi_arsize)
      ,.axi_arburst_o(m00_axi_arburst)
      ,.axi_arcache_o(m00_axi_arcache)
      ,.axi_arprot_o(m00_axi_arprot)
      ,.axi_arlock_o(m00_axi_arlock)
      ,.axi_arvalid_o(m00_axi_arvalid)
      ,.axi_arready_i(m00_axi_arready)

      ,.axi_rid_i(m00_axi_rid)
      ,.axi_rdata_i(m00_axi_rdata)
      ,.axi_rresp_i(m00_axi_rresp)
      ,.axi_rlast_i(m00_axi_rlast)
      ,.axi_rvalid_i(m00_axi_rvalid)
      ,.axi_rready_o(m00_axi_rready)
      );

	// User logic ends

endmodule
