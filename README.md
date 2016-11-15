# VersionAlertView-Swift

<html>
<body>
<h2>什么是 VersionAlertView-Swift</h2>
<p>这是一个基于swift语言实现更新版本提示框</p>
<p>OC代码链接：https://github.com/zhanghongdou/VersionAlertView-OC.git </p>
<h2>效果图展示</h2>

<h3>强制更新效果图</h3>
<p><img src="picture/0BDF60CA-4EC4-4D43-ABB7-72A9A72CAAB4.png"/></p>

<h3>非强制更新效果图</h3>
<p><img src="picture/1D46FF2A-9410-4347-8E4C-0D802044D4CF.png"/></p>


<h2>使用方法</h2>
<p style="font-size:16px">

<span style="font-size:16px;color:green;">//updateDetailArray:传入更新的内容数组</span></br>
<span style="font-size:16px;color:green;">//isForcedUpdate:是否进行强制更新</span></br>
<span style="font-size:16px;color:green;">//versionStr：版本号</span></br>
<span style="font-size:16px;color:green;">//updateURLString：跳转地址</span></br>
    <span style="font-size:16px;color:red;">let</span>versionAlertView = VersionAlertView.<span style="font-size:16px;color:red;">init</span>(updatedDelArray: [<span style="font-size:16px;color:red;">"修复bug","增加内购功能"</span>], isForcedUpdate: <span style="font-size:16px;color:red;">true</span>, versionStr: <span style="font-size:16px;color:red;">"V2.5.0"</span>,updateURLString: <span style="font-size:16px;color:red;">"传入appsore跳转地址"</span>)</br>
        versionAlertView.show()</br>
</p>
</body>

</html>