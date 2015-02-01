//
//  PHPServerSide.swift
//  jsonPost
//
//  Created by Devin Yang on 2015/2/1.
//  Copyright (c) 2015年 Devin Yang. All rights reserved.
//

/*
單純放Server端的源始碼
<?php
//$str="[{\"str\":\"Hello\",\"num\":1},{\"str\":\"Goodbye\",\"num\":99}]";

$str=stripslashes($_POST["json"]); //要把斜線移掉才能json_decode
$json=json_decode($str,true);
/*
下方的foreach中除了抓出了iOS送來的資料，再補了一些資料送回給iOS
*/
foreach($json as $v){
$arrData[]=array(
"num"=>$v["num"],
"str"=>$v["str"],
"test"=>array(
"stat"=>"ok",
"sub"=>"子項測試"
)
);
}
//把上方的資料再回傳給iOS Device
echo json_encode($arrData);
?>
*/
