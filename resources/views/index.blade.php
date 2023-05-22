<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
<!-- BEGIN: Head-->

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>Hospital Managment System</title>
    <link rel="apple-touch-icon" href="{{ asset('temp/app-assets/images/ico/favicon.png') }}">
    <link rel="shortcut icon" type="image/x-icon" href="{{ asset('temp/app-assets/images/ico/favicon.ico') }}">

    <link
        href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i%7COpen+Sans:300,300i,400,400i,600,600i,700,700i"
        rel="stylesheet">

    <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" type="text/css" href="{{ asset('temp/app-assets/vendors/css/vendors.min.css') }}">
    <link rel="stylesheet" type="text/css"
        href="{{ asset('temp/app-assets/vendors/css/tables/datatable/datatables.min.css') }}">
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="{{ asset('temp/app-assets/css/bootstrap.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('temp/app-assets/css/bootstrap-extended.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('temp/app-assets/css/colors.css') }}">
    <link rel="stylesheet" type="text/css" href="{{ asset('temp/app-assets/css/components.css') }}">
    <!-- END: Theme CSS-->

    <!-- BEGIN: Page CSS-->
    <link rel="stylesheet" type="text/css"
        href="{{ asset('temp/app-assets/css/core/menu/menu-types/vertical-menu.css') }}">
    <link rel="stylesheet" type="text/css"
        href="{{ asset('temp/app-assets/css/core/colors/palette-gradient.css') }}">
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="{{ asset('temp/assets/css/style.css') }}">
    <!-- END: Custom CSS-->

    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"
        integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous" />

    <link type="text/css" href="{{ asset('css/app.css') }}" rel="stylesheet" />

    <style>
        .inactive-row {
            background-color: #d0d2d6 !important;
            color: #000 !important;
        }

    </style>
</head>
<!-- END: Head-->

<!-- BEGIN: Body-->

<body class="vertical-layout vertical-menu 2-columns fixed-navbar" data-open="click" data-menu="vertical-menu"
    data-col="2-columns">
    <div id="app"
        data-user="{{ auth()->check()
    ? auth()->user()->load('employee.role', 'permissions')
    : null }}">
        <root-app />
    </div>
</body>
<!-- END: Body-->

<!-- BEGIN: Vendor JS-->
<script src="{{ asset('temp/app-assets/vendors/js/vendors.min.js') }}"></script>
<script src="{{ asset('temp/app-assets/vendors/js/tables/datatable/datatables.min.js') }}"></script>
<!-- BEGIN Vendor JS-->



<script type="text/javascript" src="{{ asset('temp/app-assets/vendors/js/tables/pdfmake.min.js') }}"></script>
<script type="text/javascript" src="{{ asset('temp/app-assets/vendors/js/tables/vfs_fonts.js') }}"></script>

<script>
    pdfMake.fonts = {
        Amiri: {
            normal: "Amiri-Regular.ttf",
            bold: "Amiri-Regular.ttf",
            italics: "Amiri-Regular.ttf",
            bolditalics: "Amiri-Regular.ttf",
        },
    };

</script>
<script src="{{ asset('js/app.js') }}"></script>

</html>
