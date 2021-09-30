<%@ Control Language="C#" AutoEventWireup="true" CodeFile="controlPopupListaSitios.ascx.cs" Inherits="controlPopupListaSitios" %>
<%@ Register Assembly="Infragistics2.WebUI.UltraWebGrid.v7.3, Version=7.3.20073.38, Culture=neutral, PublicKeyToken=7dd5c3163f2cd0cb"
    Namespace="Infragistics.WebUI.UltraWebGrid" TagPrefix="igtbl" %>
<script type="text/javascript" src="javascript/gpsScriptPage.js"></script>
    <div style="position:absolute; left:auto;top: 30px; right:10px"><input type="button" onclick="toggle()" value="Lista de sitios" class="formatButton" /></div>
<div id="controlUsuarioSitios" style="position:absolute; left:auto;top: 50px; right:10px;visibility:hidden">
    <igtbl:UltraWebGrid ID="uwgSitios" runat="server" Height="400px" EnableAppStyling="False" EnableTheming="False" Width="300px">
        <Bands>
            <igtbl:UltraGridBand>
                <AddNewRow View="NotSet" Visible="NotSet">
                </AddNewRow>
                <Columns>
                    <igtbl:UltraGridColumn Width="100px" Key="NomSitioCliente" BaseColumnName="NomSitioCliente" IsBound="True">
                        <Header Caption="Nombre" Title="Nombre">
                        </Header>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn Width="120px" Key="Cod_RefSitioCliente" BaseColumnName="Cod_RefSitioCliente" IsBound="True">
                        <Header Caption="C&#243;digo" Title="Codigo">
                            <RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="1"></RowLayoutColumnInfo>
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn Width="150px" Key="DirSitioCliente" BaseColumnName="DirSitioCliente" IsBound="True">
                        <Header Caption="Direcci&#243;n" Title="Direccion">
                            <RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="2"></RowLayoutColumnInfo>
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn Key="Latitud" BaseColumnName="Latitud" Hidden="True" IsBound="True">
                        <Header Caption="Latitud" Title="Latitud">
                            <RowLayoutColumnInfo OriginX="3"></RowLayoutColumnInfo>
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="3"></RowLayoutColumnInfo>
                        </Footer>
                    </igtbl:UltraGridColumn>
                    <igtbl:UltraGridColumn Key="Longitud" BaseColumnName="Longitud" Hidden="True" IsBound="True">
                        <Header Caption="Longitud" Title="Longitud">
                            <RowLayoutColumnInfo OriginX="4"></RowLayoutColumnInfo>
                        </Header>
                        <Footer>
                            <RowLayoutColumnInfo OriginX="4"></RowLayoutColumnInfo>
                        </Footer>
                    </igtbl:UltraGridColumn>
                </Columns>
            </igtbl:UltraGridBand>
        </Bands>
        <DisplayLayout Version="4.00" AllowSortingDefault="OnClient" UseFixedHeaders="True"
            AllowColSizingDefault="Free" StationaryMarginsOutlookGroupBy="True" CellClickActionDefault="RowSelect"
            HeaderClickActionDefault="SortSingle" Name="ctl00xuwgSitios" BorderCollapseDefault="Separate"
            RowSelectorsDefault="No" TableLayout="Fixed" RowHeightDefault="20px"
            AllowColumnMovingDefault="NotSet" SelectTypeColDefault="Single" SelectTypeRowDefault="Single" AutoGenerateColumns="False" GridLinesDefault="Horizontal" NoDataMessage="No ha creado ning&#250;n sitio">
            <GroupByBox>
                <BandLabelStyle ForeColor="White" BackColor="#6372D4">
                </BandLabelStyle>
                <BoxStyle ForeColor="#3C7FB1" BorderColor="Window" Font-Bold="True" BackColor="#3C7FB1" Height="40px">
                </BoxStyle>
            </GroupByBox>
            <GroupByRowStyleDefault BackColor="#F4FBFE">
            </GroupByRowStyleDefault>
            <ActivationObject BorderWidth="1px" BorderStyle="Solid" BorderColor="204, 237, 252">
                <BorderDetails WidthRight="0px" WidthLeft="0px"></BorderDetails>
            </ActivationObject>
            <FooterStyleDefault BorderWidth="1px" BorderStyle="Solid" BackColor="LightGray">
                <BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
            </FooterStyleDefault>
            <RowStyleDefault Font-Size="XX-Small" Font-Names="Trebuchet MS,Verdana,Arial,sans-serif"
                BackColor="Window" Height="19px">
                <BorderDetails StyleLeft="Solid" WidthLeft="1px" WidthTop="0px" ColorLeft="230, 230, 230">
                </BorderDetails>
                <Padding Left="6px"></Padding>
            </RowStyleDefault>
            <FilterOptionsDefault>
                <FilterOperandDropDownStyle BorderWidth="1px" BorderColor="Silver" BorderStyle="Solid"
                    Font-Size="11px" Font-Names="Verdana,Arial,Helvetica,sans-serif" BackColor="White"
                    CustomRules="overflow:auto;">
                    <Padding Left="2px"></Padding>
                </FilterOperandDropDownStyle>
                <FilterHighlightRowStyle ForeColor="White" BackColor="#151C55">
                </FilterHighlightRowStyle>
                <FilterDropDownStyle BorderWidth="1px" BorderColor="Silver" BorderStyle="Solid" Font-Size="11px"
                    Font-Names="Verdana,Arial,Helvetica,sans-serif" BackColor="White" Width="200px"
                    CustomRules="overflow:auto;">
                    <Padding Left="2px"></Padding>
                </FilterDropDownStyle>
            </FilterOptionsDefault>
            <RowSelectorStyleDefault BackgroundImage="none" BackColor="White">
            </RowSelectorStyleDefault>
            <SelectedRowStyleDefault BorderWidth="0px" BorderStyle="None" BackColor="#E0F1F9" CustomRules="background-repeat: repeat-x;">
                <Padding Left="7px"></Padding>
            </SelectedRowStyleDefault>
            <HeaderStyleDefault ForeColor="#555555" HorizontalAlign="Left" BorderStyle="None" Font-Size="XX-Small"
                Font-Names="Trebuchet MS,Verdana,Arial,sans-serif" Font-Bold="True" Height="23px"
                Cursor="Hand">
                <BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
                <Padding Left="5px"></Padding>
            </HeaderStyleDefault>
            <EditCellStyleDefault BorderStyle="None" Font-Size="XX-Small" Font-Names="Trebuchet MS,Verdana,Arial,sans-serif"
                BackColor="White">
                <Margin Top="0px" Left="4px" Bottom="0px" Right="0px"></Margin>
                <Padding Top="0px" Left="2px" Bottom="0px" Right="0px"></Padding>
            </EditCellStyleDefault>
            <FrameStyle BorderWidth="1px" BorderColor="#E6E6E6" BorderStyle="Solid" Font-Size="XX-Small"
                Font-Names="Arial" BackColor="WhiteSmoke" Height="400px" Width="300px">
            </FrameStyle>
            <Pager>
                <PagerStyle BorderWidth="1px" BorderStyle="Solid" BackColor="Red">
                    <BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
                </PagerStyle>
            </Pager>
            <AddNewBox Hidden="False">
                <BoxStyle BorderWidth="1px" BorderColor="InactiveCaption" BorderStyle="Solid" BackColor="Window">
                    <BorderDetails ColorTop="White" WidthLeft="1px" WidthTop="1px" ColorLeft="White"></BorderDetails>
                </BoxStyle>
            </AddNewBox>
            <ClientSideEvents CellClickHandler="ctrlPopupListaSitiosIrASitioSeleccionado" />
        </DisplayLayout>
    </igtbl:UltraWebGrid>
</div>
<asp:HiddenField ID="hdncod_Flota" runat="server" />