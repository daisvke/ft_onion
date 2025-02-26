<?php
require_once("header.php");
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <?php require_once("head.php"); ?>
    <meta name="description" content="<?php echo strtoupper(NAME) ?>
        Make your slate notes available from anywhere."
        />
    <title><?php echo ucwords(NAME) ?></title>
</head>

<body>
<!--------------- ASCII HEADER LOGO --------------->
<?php require_once("assets/img/ascii_logo.html"); ?>

<!--------------- MAIN CODE --------------->
<div class="fade-in full-height">
    <?php require_once("slate_writer.php"); ?>
</div>

<!--------------- FOOTER --------------->
<?php require_once("footer.php"); ?>
</body>
</html>