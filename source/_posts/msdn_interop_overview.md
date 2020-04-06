---
title: MSDN阅读笔记——互操作技术
date: 2019-6-5
tags: [msdn, work, csharp]
---

在.NET平台上，C#可以用的互操作技术主要就是P/Invoke和COM，本文基于[MSDN](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/interop/interoperability-overview)进行了一些理解和说明。

# Platform Invoke
Platform invoke是一种可以让托管代码调用DLL中的非托管函数的服务，比如Windows API，