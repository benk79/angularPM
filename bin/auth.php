<?php
$link = mysqli_connect('localhost', 'user', 'password', 'database');
mysqli_set_charset($link,'utf8');

$input = json_decode(file_get_contents('php://input'),true);
// echo $input;
ini_set("session.cookie_path", "/project");
session_start();

$sql = "SELECT * FROM pp_users WHERE `username` = '".mysqli_real_escape_string($link,(string)$input['username'])."' AND `password` = '".mysqli_real_escape_string($link,(string)$input['password'])."' ;";

$result = mysqli_query($link,$sql);

header('Content-Type: application/json');


if(mysqli_num_rows($result)){
	$user = mysqli_fetch_object($result);
	unset($user->password);
	$user->auth = true;
	$_SESSION['user'] = $user;
    echo json_encode($user);
} else {
	echo '{"auth":false}';
}
?>