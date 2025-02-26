<?php require_once("../header.php"); ?>

<!DOCTYPE html>
<html lang="en">
<head>
    <?php require_once("../head.php"); ?>
    <meta name="description" content="<?php echo strtoupper(NAME) ?> <?= $title ?>">
    <title><?= $title ?></title>
</head>

<body>
<!--------------- ASCII ART --------------->
<?php require_once("../assets/img/ascii_logo.html"); ?>

<main class="fade-in full-height" style="margin-top: 10vh;">
    <!--------------- CONTENT --------------->
    <h1 class="center-text" id="error-page-title"><?= $code ?></h1>

    <p class="center-text">
        <?= $message ?>
    </p>
</main>

<!--------------- FOOTER --------------->
<?php require_once("../footer.php"); ?>
</body>
</html>