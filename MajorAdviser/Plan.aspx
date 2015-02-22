<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Plan.aspx.cs" Inherits="MajorAdviser.Plan" MasterPageFile="~/Site.Master" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript" src="http://malsup.github.com/jquery.cycle.all.js"></script>
    <style>
        .activeSlide {
            color: #fff;
            background-color: #666;
            padding: 5px;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#slideshow').cycle({
                fx: 'fade', // choose your transition type, ex: fade, scrollUp, shuffle, etc...
                speed: 300,
                timeout: 0,
                pager: '#pager'
            });
            $('#pager a').click(function () {
                $(this).blur();
            });
            $('#pager a').each(function () {
                if ($(this).html() === '1') {
                    $(this).html('Project Specifications').after('&nbsp;&nbsp;&nbsp;&nbsp;');;
                }
                if ($(this).html() === '2') {
                    $(this).html('AA Degree').after('&nbsp;&nbsp;&nbsp;&nbsp;');
                }
                if ($(this).html() === '3') {
                    $(this).html('AS Degree').after('&nbsp;&nbsp;&nbsp;&nbsp;');;
                }
                if ($(this).html() === '4') {
                    $(this).html('BSET Degree').after('&nbsp;&nbsp;&nbsp;&nbsp;');;
                }
                if ($(this).html() === '5') {
                    $(this).html('Program Guides').after('&nbsp;&nbsp;&nbsp;&nbsp;');;
                }
                if ($(this).html() === '6') {
                    $(this).html('Programs').after('&nbsp;&nbsp;&nbsp;&nbsp;');;
                }
                if ($(this).html() === '7') {
                    $(this).html('Programs Structure').after('&nbsp;&nbsp;&nbsp;&nbsp;');;
                }
                if ($(this).html() === '8') {
                    $(this).html('Student Information').after('&nbsp;&nbsp;&nbsp;&nbsp;');;
                }
            });
        });
    </script>
    <h1>Major Adviser Plan</h1>
    <p>Roger and Shawn have been working on plans for the major adviser project here are a few of the 
        documents we have created:</p>
    <div id="pager"></div>
    <br />
    <div id="slideshow">
        <img src="~/Images/ProjectSpecs.jpg" height="500" runat="server" />
        <img src="~/Images/AADegree.jpg" height="350" runat="server" />
        <img src="~/Images/ASDegree.jpg" height="350" runat="server" />
        <img src="~/Images/BSETDegree.jpg" height="250" runat="server" />
        <img src="~/Images/ProgramGuides.jpg" height="500" runat="server" />
        <img src="~/Images/Programs.jpg" height="350" runat="server" />
        <img src="~/Images/ProgramStructure.jpg" height="350" runat="server" />
        <img src="~/Images/StudentInformation.jpg" height="350" runat="server" />
    </div>
    <h3>User Goals</h3>
    <p>As a guest you will be able to view degrees available, and the basic requirements for those degrees.</p>
    <p>As a member of the site you will be able to keep track of completed classes, and be able to see what 
        classes you have left to complete.</p>
    <p>As an administrator you will be able to edit the degree requirements and the course details.</p>
    <p>Prerequisites will be handled by letting the users know when class requirements have been met.</p>
    <h3>Pages</h3>
    <p>Default(Guest): a page that has a drop down of available degrees. 
        When a degreee is selected the basic requirements are displayed below.</p>
    <p>Default(Member): a page that has a drop down of available degrees. 
        When a degreee is selected the remaining requirements for the member are displayed below. 
        Maybe the completed classes are a certain color and in progress classes another color.
    </p>
    <p>Classes(Member): a page that displays the classes in progress and completed</p>
    <p>AdminPanel(Administrator): Edit degree requirements and class details.</p>
</asp:Content>
