#### 前言
###### 权当笔记, 之后发布SDK的时候需要使用到该功能, 这篇文章主要讲述如何使自己的工具类或者SDK支持cocoapods的方式导入. 大多数步骤都是在终端中使用命令行操作的. 所以下面就直接贴指令了. 可以去**[我的github](https://github.com/WilliamAlex/MZRobotSDK.git)**看看podspec文件的配置
- 在github上创建仓库MOZI, 创建时需要注意的是一定要选择开源协议. 比如选择MIT.
- 创建本地仓库, 将远程仓库MOZI clone到桌面上, 并cd到该目录下.
-  创建一个podspec文件
```objc
 $ pod spec create MOZI
```
- 编辑podspec文件(可以使用vim打开):vim MOZI.podspec, 打开podspec文件之后, 需要修改一些文件, 可以直接在github上参考开源项目的spodspec文件.比如参照AFN的podspec文件.
![AFN的podspec.png](https://upload-images.jianshu.io/upload_images/1659233-caa0cbddc7b678a9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```objc
Pod::Spec.ne do |s|
s.name  = 'AFNetworking'
s.version  = '3.2.1'
s.license  = ‘MIT'
s.summary  = 'A delightful iOS and OS X networking framework.'
s.homepage = 'https://github.com/AFNetworking/AFNetworking'
s.social_media_url = 'https://twitter.com/AFNetworking'
s.authors  = { 'Mattt Thompson' => 'm@mattt.me’ }
s.source  = { :git => 'https://github.com/AFNetworking/AFNetworking.git', :tag => s.version, :submodules => true }
s.requires_arc = true
s.public_header_files = 'AFNetworking/AFNetworking.h’
s.source_files = 'AFNetworking/AFNetworking.h'
s.prefix_header_contents = pch_AF
s.ios.deployment_target = ‘7.0'
end
```
```objc
注释:
s.name: 名称, pos.search时搜索的关键字, 需要注意的是这里的名称一定要和.podspec文件的名称要是一样的, 否则会报错哦
s.version: 当前的版本号
s.license: 开源协议
s.summary: 简介
s.description : 描述, 用于生成标签和提高搜索结果, 主要是类库的功能等, 尽量简短; 注意, 需要写在两个DESC中间
s.homepage: 项目主页的地址,
s.social_media_url: 社交地址
s.authors: 作者
s.requires_arc: 是否支持ARC
s.public_header_files: 项目的头文件
s.source: 项目地址
s.resources: 资源文件
s.dependency: 依赖库, 切记不能依赖未发布的库
# 依赖的系统框架
# s.framework  = “SomeFramework”
# s.frameworks = "SomeFramework", “AnotherFramework"

#第三方依赖
s.dependency "Masonry", "~>0.6”
 如果有多个第三方库，就写多个 s.dependency
```
> 注意点:
如果有多个依赖框架: 
 s.frameworks = "SomeFramework", “AnotherFramework"
如果有多个第三方依赖:  有多个第三方库，就写多个 s.dependency
s.dependency "Masonry", "~>0.6”
s.dependency "AFNetworking", "~>0.6”
s.dependency "YYKit", "~>0.6”

- 创建tag值
```objc
7.1,$ git add . 
7.2, $ git commit -m “0.0.1”
7.3, $ git tag 0.0.1
7.4, $ git push —tags
7.5, $ git push origin master
```
- 验证podspec文件是否配置正确
```objc
$ pod spec lint MOZI.podspec
```
> 注意点:
1, 如果终端中存在警告可以使用忽略警告的命令行: pod spec lint MOZI.podspec --allow-warnings
2, 如果验证不通过, 终端中会有详细的error, 根据提示来做就好了, 重新验证, 直到没有错误为止.
3, 如果通过验证, 终端中会有提示”通过验证的提示(passed validation)”
![成功后会有通过的提示.png](https://upload-images.jianshu.io/upload_images/1659233-8ee58b1c1794b5c7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 如果是第一次提交, 需要填写几个信息:
```objc
$ pod trunk register 这里写您的邮箱 '这里需要起个名字' --description=' 这里写一些描述’

eg: $ pod trunk register 1509159596@qq.com 'Alex'  --description="I`m just a boy"
```
- 完成之后, 会发一封邮件到您写的邮箱中, 点击链接即可.
![在podspec文件中配置的邮箱会收到这样的文件.png](https://upload-images.jianshu.io/upload_images/1659233-560a76c9e7c50026.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 提交到cocoapods:
```objc
$ pod trunk push MOZI.podspec --allow-warnings
```
> (注意:由于我验证podspec文件时使用了--allow-warnings 所以这里后面也加上--allow-warnings)

![提交成功后的终端的提示.png](https://upload-images.jianshu.io/upload_images/1659233-5c4d98bbe34b3c09.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 通过终端去pod.search一下, 查看是否成功.
```objc
$ pod search MOZI
```
>  刚提交后项目用pod search命令会搜不到，因为本地的索引没有更新，使用下面命令删除索引文件, 删除之后再一次进行 pod search mozi

```objc
$ rm ~/Library/Caches/CocoaPods/search_index.json
```
![第一次搜索不到.png](https://upload-images.jianshu.io/upload_images/1659233-c841f3cce1a9bfae.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 删除search_index.json后再一次搜索
![最终效果.png](https://upload-images.jianshu.io/upload_images/1659233-441cee7bff8695e6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> 需要注意的几点:
1, 整个过程中最难的部分就是podspec文件的配置. 不懂的一般都是去github上看别人的podspec是怎么样配置的.
2, 在验证podspec文件是否配置正确的过程中, 如果有错, 终端会有提示你错在哪里, 根据提示来做就可以了.
3, s.source_files表示的是路径, 我在这里花费的时间相对其他地方多了一点.


####  总结
"不积跬步, 无以至千里", 希望每天都能进步一点. 多学习一些感兴趣的东西.









