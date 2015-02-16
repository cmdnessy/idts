<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="idtstrack.aspx.cs" Inherits="iDTS.idtstrack" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style type="text/css">
    <!--
body{margin:0px; padding:0px;}
#fl_menu{position:absolute; 
         top:50px; 
         left:0px; 
         z-index:9999; 
         width:150px; 
         height:50px;
         -webkit-box-shadow: 0px 3px 5px rgba(100, 100, 100, 0.49);
         -moz-box-shadow:    0px 3px 5px rgba(100, 100, 100, 0.49);
          box-shadow:         0px 3px 5px rgba(100, 100, 100, 0.49);}
#fl_menu .label{padding-left:20px; line-height:50px; font-family:"Arial Black", Arial, Helvetica, sans-serif; font-size:14px; font-weight:bold; background:#000; color:#fff; letter-spacing:7px;}
#fl_menu .menu{display:none;}
#fl_menu .menu .menu_item{display:block; 
                          background:#fdf5ac; 
                          color:#000; 
                          border:2px solid #cacaca; 
                          padding:10px 20px 20px 10px; 
                          font-family:Arial, Helvetica, sans-serif; 
                          font-size:12px; 
                          text-decoration:none;
                          -webkit-box-shadow: 0px 3px 5px rgba(100, 100, 100, 0.49);
                          -moz-box-shadow:    0px 3px 5px rgba(100, 100, 100, 0.49);
                          box-shadow:         0px 3px 5px rgba(100, 100, 100, 0.49);}
#fl_menu .menu a.menu_item:hover{background:#333; color:#fff;}
.content{width:520px; margin:50px auto;}
-->
    </style>
    <title>DTS</title>
    <link href="~/image/aklan_logo.ico" rel="icon" type="image/x-icon" />
    <link href="~/image/aklan_logo.ico" rel="shortcut icon" type="image/x-icon"/>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
    <!-- <script type="text/javascript" srchttp://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script> -->
    <script type="text/javascript" src="jquery.easing.1.3.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="fl_menu">
	        <div class="label">ABOUT</div>
	        <div class="menu">
                <p class="menu_item">Document Tracking System</p>
                <p class="menu_item">PROGRAMMER / DEVELOPER: Donald R. Rubio</p>
                <p class="menu_item">Copyright ©<%= CurrentYear %></p>
            </div>
        </div>
        <div align="center">
            <asp:Image ID="Image1" runat="server" ImageUrl="~/image/idtslogo.jpg" />
        </div>
        <div align="center">
            <asp:TextBox ID="txt_search" runat="server" Font-Names="Corbel" 
            Font-Size="X-Large" BackColor="#FDF5AC" Width="250px"></asp:TextBox>
        </div>
        <div align="center">
            <asp:Button ID="Button1" runat="server" Font-Size="Large" 
            onclick="btnsearch_Click" Text="SEARCH" Width="250px" />
            
        </div>
        <br />
        <div align="center">
            <asp:Table ID="docDetailsHead" runat="server" CellPadding="5"
            GridLines="vertical" HorizontalAlign="Center" Width="500px" 
                BorderColor="Maroon" BorderStyle="Groove">
               <asp:TableRow BackColor="#FFFBD6" ForeColor="Black">
                 <asp:TableCell>DOCUMENT DETAILS</asp:TableCell>
               </asp:TableRow>
            </asp:Table>
        </div>
        <div align="center">
            <asp:Table ID="docDetails" runat="server" CellPadding="5"
            GridLines="Both" HorizontalAlign="Center" BackColor="#990000" 
                BorderStyle="Groove" ForeColor="White" Width="500px" BorderColor="#990000">
               <asp:TableRow>
                 <asp:TableCell Font-Names="Corbel">DOCUMENT TYPE</asp:TableCell>
                 <asp:TableCell><asp:Label ID="lbl_type" runat="server" Text="Label" Font-Bold="True" 
                            Font-Names="Corbel" Font-Size="Medium"></asp:Label></asp:TableCell>
               </asp:TableRow>
               <asp:TableRow>
                 <asp:TableCell Font-Names="Corbel">VOUCHER NO.</asp:TableCell>
                 <asp:TableCell><asp:Label ID="lbl_voucher" runat="server" Text="Label" Font-Bold="True" 
                            Font-Names="Corbel" Font-Size="Medium"></asp:Label></asp:TableCell>
               </asp:TableRow>
            </asp:Table>
        </div>
        <div align="center">
            <br />
            <asp:Label ID="lblmsg" runat="server" Text="Label" Font-Bold="True" 
                Font-Names="Courier New" Font-Size="Medium"></asp:Label>
            <br />
        </div>
        <div align="center">
             <asp:GridView ID="grdHistory" runat="server" AutoGenerateColumns="False" 
                CellPadding="4" Font-Names="Courier New" Font-Size="Medium" 
                ForeColor="#333333" BorderStyle="Solid" CellSpacing="2">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="dochist_action" HeaderText="ACTION DONE" 
                        SortExpression="dochist_action" />
                    <asp:BoundField DataField="dochist_date" HeaderText="DATE / TIME" 
                        SortExpression="dochist_date" />
                    <asp:BoundField DataField="dochist_remarks" HeaderText="REMARKS" 
                        SortExpression="dochist_remarks" />
                    <asp:BoundField DataField="dochist_processtime" HeaderText="PROCESS TIME" 
                        SortExpression="dochist_processtime" />
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                <SortedAscendingCellStyle BackColor="#FDF5AC" />
                <SortedAscendingHeaderStyle BackColor="#4D0000" />
                <SortedDescendingCellStyle BackColor="#FCF6C0" />
                <SortedDescendingHeaderStyle BackColor="#820000" />
            </asp:GridView>
        </div>
        
        <asp:SqlDataSource ID="SqliDTSHist" runat="server" 
            ConnectionString="<%$ ConnectionStrings:dtsConnectionString %>" 
            SelectCommand="SELECT [transno], [dochist_action], [dochist_date], [dochist_remarks], [dochist_processtime] FROM [tbl_dochist]">
        </asp:SqlDataSource>
        <script>
            //config
            $float_speed = 1500; //milliseconds
            $float_easing = "easeOutQuint";
            $menu_fade_speed = 3000; //milliseconds
            $closed_menu_opacity = 0.75;

            //cache vars
            $fl_menu = $("#fl_menu");
            $fl_menu_menu = $("#fl_menu .menu");
            $fl_menu_label = $("#fl_menu .label");

            $(window).load(function () {
                menuPosition = $('#fl_menu').position().top;
                FloatMenu();
                $fl_menu.hover(
		function () { //mouse over
		    $fl_menu_label.fadeTo($menu_fade_speed, 1);
		    $fl_menu_menu.fadeIn($menu_fade_speed);
		},
		function () { //mouse out
		    $fl_menu_label.fadeTo($menu_fade_speed, $closed_menu_opacity);
		    $fl_menu_menu.fadeOut($menu_fade_speed);
		}
	);
            });

            $(window).scroll(function () {
                FloatMenu();
            });

            function FloatMenu() {
                var scrollAmount = $(document).scrollTop();
                var newPosition = menuPosition + scrollAmount;
                if ($(window).height() < $fl_menu.height() + $fl_menu_menu.height()) {
                    $fl_menu.css("top", menuPosition);
                } else {
                    $fl_menu.stop().animate({ top: newPosition }, $float_speed, $float_easing);
                }
            }
</script>

    </form>
</body>
</html>
