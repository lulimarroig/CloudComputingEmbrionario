<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="SciCloud.aspx.cs" Inherits="Web_Role.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contenido" runat="server">
    <!-- Navigation -->
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">Inicio</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="#sectionThree">Simular</a>
                    </li>
                    <li>
                        <a href="#sectionFour">Obtener resultados</a>
                    </li>                    
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>

    <!-- Header -->
    <div class="intro-header">

        <div class="container">

            <div class="row">
                <div class="col-lg-12">
                    <div class="intro-message">
                        <h1>Cloud Computing</h1>
                        <h3>Windows Azure Development</h3>
                        <hr class="intro-divider">
                        <ul class="list-inline intro-social-buttons">
                            <li>
                            <a href="http://www.fing.edu.uy/inco/inicio" id="inco" target="_blank" class="btn btn-default btn-lg"><asp:Image CssClass="img-responsive" runat="server" ImageUrl="~/Images/logoInco.png" /></a>
                            </li>
                            <li>
                                <a href="http://exactas.uba.ar/academico/display.php?estructura=2&desarrollo=0&id_caja=227&nivel_caja=2" target="_blank" class="btn btn-default btn-lg"><asp:Image ID="Image2" CssClass="img-responsive" runat="server" ImageUrl="~/Images/logoUba.png" /></a>
                            </li>
                            <li>
                                <a href="http://www.mcell.cnl.salk.edu/" target="_blank" class="btn btn-default btn-lg"><i class="fa fa-linkedin fa-fw"><asp:Image ID="mcell1" CssClass="img-responsive" runat="server" ImageUrl="~/Images/mcell.png" /></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
        <!-- /.container -->

    </div>
    <!-- /.intro-header -->

    <!-- Page Content -->

    <div id="sectionOne" class="content-section-a">

        <div class="container">

            <div class="row">
                <div class="col-lg-5 col-sm-6">
                    <hr class="section-heading-spacer">
                    <div class="clearfix"></div>
                    <h2 class="section-heading"><a href="#sectionThree">Comienza tu propia<br>
                        Simulación</a></h2>
                    <p class="lead">En esta sección podrás ingresar la serie de parámetros que más se adapten a tus necesidades. SciCloud se encarga de procesar y proteger tu información para que luego puedas acceder a los resultados, estás a solo un click.</p>
                </div>
                <div class="col-lg-5 col-lg-offset-2 col-sm-6">
                    <asp:Image CssClass="img-responsive" runat="server" ImageUrl="~/Images/celulas.png" />
                </div>
            </div>

        </div>
        <!-- /.container -->

    </div>
    <!-- /.content-section-a -->

    <div id="sectionTwo" class="content-section-b">

        <div class="container">

            <div class="row">
                <div class="col-lg-5 col-lg-offset-1 col-sm-push-6  col-sm-6">
                    <hr class="section-heading-spacer">
                    <div class="clearfix"></div>
                    <h2 class="section-heading"><a href="#sectionFour">Obtener resultados de la<br>
                        Simulación</a></h2>
                    <p class="lead">Puedes monitorear el progreso de tus ejecuciones, así como los resultados de aquellas que han finalizado.</p>
                </div>
                <div class="col-lg-5 col-sm-pull-6  col-sm-6">
                    <asp:Image ID="Image1" CssClass="img-responsive" runat="server" ImageUrl="~/Images/cells2.jpg" />
                </div>
            </div>

        </div>
        <!-- /.container -->
        
    </div>
    <!-- /.content-section-b -->
    
    <form id="form" runat="server" method="post">
        <asp:ScriptManager ID='ScriptManager1' runat='server' EnablePageMethods='true' />
    <div ID="sectionThree" class="content-section-a">

        <div class="container">

            <div class="row">                  
                    <div id="mensajeConfirmacion" style="display:none;">
                        <asp:Label runat="server" class="succesMsg" ID="mensajeExito"></asp:Label>
                    </div>

                    <div class="init">
                        <h1>Inicialización</h1>
                        <asp:Label runat="server">ITERATIONS</asp:Label>
                        <input runat="server" id="iterationsValue"/>
                        <br/><br/>
                        <asp:Label runat="server">TIME_STEP</asp:Label>
                        <input runat="server" id="timeStepValue"/>
                        <br/>
                    </div>

                    <div class="geometria">
                        <h1>Geometría</h1>
                        <asp:Label runat="server">Coordenadas A:</asp:Label><br/>
                        <asp:Label runat="server">x1</asp:Label>
                        <input class="coordenada" runat="server" id="x1"/>
                        <asp:Label runat="server">y1</asp:Label>                        
                        <input class="coordenada" runat="server" id="y1"/>
                        <asp:Label runat="server">z1</asp:Label>                        
                        <input class="coordenada" runat="server" id="z1"/>
                        <br/><br/>
                        <asp:Label runat="server">Coordenadas B:</asp:Label><br/>
                        <asp:Label runat="server">x2</asp:Label>                        
                        <input class="coordenada" runat="server" id="x2"/>
                        <asp:Label runat="server">y2</asp:Label>                        
                        <input class="coordenada" runat="server" id="y2"/>
                        <asp:Label runat="server">z2</asp:Label>                        
                        <input class="coordenada" runat="server" id="z2"/>
                        <br/><br/>
                        <asp:Label runat="server">ASPECT_RATIO</asp:Label>
                        <input runat="server" id="aspectRatioValue"/>
                        <br/><br/>
                        <asp:Label runat="server">MOLÉCULAS A IMPRIMIR EN RESULTADOS</asp:Label>
                        <input runat="server" id="nameListValue"/>
                    </div>
                    
                    <div class="moleculas">
                        <h1>Moléculas</h1>

                        <table runat="server" class="table table-hover" id="tablaMoleculas" >
                            <tr class="tableHeader">
                                <th>Nombre</th>
                                <th>Constante de Difusión</th>
                                <th>Constante de Difusión 2d</th>
                                <th>Cantidad</th>
                                <th></th>
                            </tr>                                                                           
                        </table>                       

                        <div id="editFormMoleculas" class="editForm" style="display: none;">
                           <table style="width:100%;">
                              <tr class="headerRow">
                                 <td>Nueva Molécula</td>
                                 <td style="text-align: right;">
                                    <a onclick="CerrarDialogoMoleculas();" style="cursor: pointer;">Cerrar</a>
                                 </td>
                              </tr>
                              <tr>
                                 <td>Nombre Molécula:</td>
                                 <td><input type="text" runat="server" id="txtNomMolecula" /></td>
                              </tr>
                              <tr>
                                 <td>Constante de Disfusión:</td>
                                 <td><input runat="server" type="text" id="txtConstDifusion" /></td>
                              </tr>
                               <tr>
                                 <td>Constante de Disfusión 2d:</td>
                                 <td><input runat="server" type="text" id="txtConstDifusion2d" /></td>
                              </tr>
                              <tr>
                                 <td>Cantidad:</td>
                                 <td><input runat="server" type="text" id="txtCant" /></td>
                              </tr>
                              <tr>
                                 <td></td>
                                 <td>
                                     <asp:Button class="btn btn-default btn-lg" runat="server" ID="agregarMoleculaBtn" OnClientClick="aceptarMolecula();return false;" Text="Aceptar"></asp:Button>                                   
                                 </td>
                              </tr>
                           </table>
                        </div>      
                                          
                        <asp:Button class="btn btn-default btn-lg" runat="server" ID="agregarMolecula" OnClientClick="MostrarDialogoMoleculas();return false;" Text="Agregar Molecula"></asp:Button>
                    </div>

                    <div class="reacciones">
                        <h1>Reacciones</h1>                 

                        <table runat="server" class="table table-hover" id="tablaReacciones" >
                            <tr class="tableHeader">
                                <th>Nombre Reacción</th>
                                <th>Reacción</th>
                                <th>Rate Inicio</th>
                                <th>Rate Fin</th>
                                <th>Rate Step</th>
                                <th></th>
                            </tr>                                                                           
                        </table>                       

                        <div id="editFormReacciones" class="editForm" style="display: none;">
                           <table style="width:100%;">
                              <tr class="headerRow">
                                 <td>Nueva Reacción</td>
                                 <td style="text-align: right;">
                                    <a onclick="CerrarDialogoReacciones();" style="cursor: pointer;">Cerrar</a>
                                 </td>
                              </tr>
                              <tr>
                                 <td>Nombre Reacción:</td>
                                 <td><input type="text" runat="server" id="txtNomReaccion" /></td>
                              </tr>
                              <tr>
                                 <td>Reacción:</td>
                                 <td><input runat="server" type="text" id="txtReaccion" /></td>
                              </tr>
                               <tr>
                                 <td>Rate inicio:</td>
                                 <td><input runat="server" type="text" id="txtInicio" /></td>
                              </tr>
                              <tr>
                                 <td>Rate Fin:</td>
                                 <td><input runat="server" type="text" id="txtFin" /></td>
                              </tr>
                               <tr>
                                 <td>Rate Step:</td>
                                 <td><input runat="server" type="text" id="txtStep" /></td>
                              </tr>
                              <tr>
                                 <td></td>
                                 <td>
                                     <asp:Button class="btn btn-default btn-lg" runat="server" ID="btnAceptarReaccion" OnClientClick="aceptarReaccion();return false;" Text="Aceptar"></asp:Button>                                   
                                 </td>
                              </tr>
                           </table>
                        </div>      

                        <asp:Button class="btn btn-default btn-lg" runat="server" ID="agregarReaccion" OnClientClick="MostrarDialogoReacciones();return false;" Text="Agregar Reacción"></asp:Button>
			        </div>

                    <div class="fernet">
		                <h1>Parámetros de Fernet</h1>

                        <select runat="server" id="fernetMode" class="btn btn-default btn-lg">
                            <option value="point" selected="selected">point</option>                            
                            <option value="multi">multi</option>
                        </select>
                        <br />
                        <br />
                    
                    </div>
                    <div class="simulationLoader" style="display:none;">
                               <img src='/Images/loading_blue.gif' style='width: 40px;'/>
                    </div>                           
                    <asp:Button runat="server" ID="simular" class="btn btn-default btn-lg" OnClientClick="simularEjecucion();return false;" Text="Simular"></asp:Button>             
                
            </div>
            <!-- /.container -->
        </div>

        <!-- /.content-section-a -->
    </div>

    <div id="sectionFour" class="content-section-b">

        <div class="container">

            <div class="row">    
                    <h1>Obtener Resultados</h1>
                    <a href="#" id="downloadLink_0" style="display:none"></a><a href="#" id="downloadLink_1" style="display:none"></a>
                    <a href="#" id="downloadLink_2" style="display:none"></a>     
                    <div runat="server">
                        <asp:Label runat="server">Ingrese el ID de su simulación: </asp:Label>
                        <input runat="server" type="text" id="IDSimulacion" onkeydown="if (event.keyCode == 13) return false;"/>
                        <asp:Button runat="server" ID="btnResultados" class="btn btn-default btn-lg" OnClientClick="obtenerResultados();return false;" Text="Obtener Resultados"></asp:Button>                                    
                    </div>                    
                    <br />  
                    <div class="editForm">
                           <div class="resultsLoader" style="display:none;">
                               <img src='/Images/loading_blue.gif' style='width: 40px;'/>
                           </div>
                           <asp:Label ID="noResultsLabel" class="noResults" style="display: none;" runat="server"><strong>No se encontraron coincidencias para el ID dado</strong></asp:Label>
                           <table id="resultsTable" class="table table-hover" style="display: none;" runat="server">
                              <tr class="tableHeader">
                                 <th>ID Job</th>
                                 <th>Estado</th>
                                 <th>MDL</th>
                                 <th>Salida Mcell</th>
                                 <th>Resultados</th>
                              </tr>                              
                           </table>
                    </div>
            </div>

        </div>
        <!-- /.container -->
        
    </div>
    <!-- /.content-section-b -->
    </form>
    <div class="banner">

        <div class="container">

            <div class="row">
                <div class="col-lg-6">
                    <h2>Links de Interés:</h2>
                </div>
                <div class="col-lg-6">
                    <ul class="list-inline intro-social-buttons">
                            <li>
                            <a href="http://www.fing.edu.uy/inco/inicio" id="A1" target="_blank" class="btn btn-default btn-lg"><asp:Image ID="Image3" CssClass="img-responsive" runat="server" ImageUrl="~/Images/logoInco.png" /></a>
                            </li>
                            <li>
                                <a href="http://exactas.uba.ar/academico/display.php?estructura=2&desarrollo=0&id_caja=227&nivel_caja=2" target="_blank" class="btn btn-default btn-lg"><asp:Image ID="Image4" CssClass="img-responsive" runat="server" ImageUrl="~/Images/logoUba.png" /></a>
                            </li>
                            <li>
                                <a href="http://www.mcell.cnl.salk.edu/" target="_blank" class="btn btn-default btn-lg"><i class="fa fa-linkedin fa-fw"><asp:Image ID="Image5" CssClass="img-responsive" runat="server" ImageUrl="~/Images/mcell.png" /></a>
                            </li>
                        </ul>
                </div>
            </div>

        </div>
        <!-- /.container -->

    </div>
    <!-- /.banner -->

    <!-- Footer -->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <ul class="list-inline">
                        <li>
                            <a href="#sectionOne">Inicio</a>
                        </li>
                        <li>
                            <a href="#sectionThree">Simular</a>
                        </li>
                        <li>
                            <a href="#sectionFour">Obtener resultados</a>
                        </li> 
                    </ul>                   
                </div>
            </div>
        </div>
    </footer>

    <!-- jQuery -->
    <%--<script src="js/jquery.js"></script>--%>

    <!-- Bootstrap Core JavaScript -->
    <%-- <script src="js/bootstrap.min.js"></script>--%>    
    <script src="Scripts/AccionesParametros.js" type="text/javascript"></script>
</asp:Content>
