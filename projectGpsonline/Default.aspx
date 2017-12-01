<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="projectGpsonline._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <%--Java skript --%>
    <script src="http://www.google.com/jsapi?key=ABQIAAAAqKXxKQCv8T9beBgr7Qn7mBRZ8s8Y-ry6aFfAhHbHnw1KqI_47hShizyCiWXuth8iL3wk_kw9MuPvKw"></script>
    <script lang ="ja">
        var Gmap;
        var directionPanel;
        var direction;

        function initialize() {

            var uluru = { lat: 40.3872976, lng: 48.0472655 };
            Gmap = new google.maps.Map(document.getElementById("map"),{

                zoom: 7,
                center: uluru

            });

            directionPanel = document.getElementById("route");
            direction = new GDirections(Gmap, directionPanel);

        }
        $(document).ready(function () {
            initialize();
            $('#bntGetDirection').click(function () {
                PopulateDirection();
            })
        })

        function PopulateDirection() {
            var from = $('#<%=ddFrom.ClientID%>').val();
            var to = $('#<%=ddTo.ClientID%>').val();
            $.ajax({
                url: "Default.aspx/GetDirection",
                type: "POST",
                data: "{from: '" + from + "',to:'" + to +"'}",
                dataType: "json",
                contentType: "application/json;charset-utf-8",
                success: function (data) {
                },
                error: function () {
                    alert("Error!")
                }
            })

        }

    </script>
    <script async defer
        src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCcn4usHg7XaaKA8xYoZlyIfQ8jIzotM60&callback=initialize">
    </script>    
    <br />
    <table>
        <tr>
            <td>From: </td>
            <td>
                <asp:DropDownList ID="ddFrom" runat="server"></asp:DropDownList>
            </td>
            <td>To: </td>
            <td>
                <asp:DropDownList ID="ddTo" runat="server"></asp:DropDownList>
            </td>
            <td>
                <input type ="button" value ="Get Direction" id="bntGetDirection" />
            </td>
        </tr>
    </table>
    <br />
    <div id="map" style="width:100%;height:500px;border:solid 1px black;float:left"></div>
<%--    <div id="route" style="width:30%;height:300px;border:solid 1px black;float:left;overflow:auto"></div>--%>
    
</asp:Content>
