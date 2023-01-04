<template>
  <div class="app-container home">
    <el-row :gutter="20">
      <el-col :xs="24" :sm="24" :md="12" :lg="14">
        <el-card class="update-log">
          <div slot="header" class="clearfix">
            <span>联系信息</span>
          </div>
          <div class="body">
            <p>
              <i class="el-icon-user-solid"></i> QQ群：
              <a href="https://jq.qq.com/?_wv=1027&k=2zE87c2G" target="_blank"
              > 782924350</a
              >
            </p>
            <p>
              <i class="el-icon-chat-dot-round"></i> 微信：<a
            >Almost-2y</a
            >
            </p>
            <p style="color: #f54a4a;font-size:16px">
              <i class="el-icon-bell"></i> 说明：<a
            >技术咨询、业务定制等其它支持可添加 微信: Almost-2y / QQ: 846249920 进行沟通交流</a
            >
            </p>
            <p>
              <i class="el-icon-shopping-bag-2"></i> 腾讯云秒杀：<a style="color: #365be4" href="https://curl.qcloud.com/W5KFkBG4" target="_blank"
            >点我进入</a>
            </p>
            <p>
              <i class="el-icon-shopping-bag-2"></i> 腾讯云服务器：<a style="color: #365be4" href="https://curl.qcloud.com/AacfyRxq" target="_blank"
            >点我进入</a>
            </p>
            <p>
              <i class="el-icon-shopping-bag-2"></i> 阿里云优惠：<a style="color: #365be4" href="https://www.aliyun.com/activity/daily/bestoffer?userCode=q2b8atsa" target="_blank"
            >点我进入</a>
            </p>
            <p>
              <i class="el-icon-shopping-bag-2"></i> 阿里云服务器：<a style="color: #365be4" href="https://www.aliyun.com/daily-act/ecs/activity_selection?userCode=q2b8atsa" target="_blank"
            >点我进入</a>
            </p>
          </div>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="24" :md="12" :lg="10">
        <el-card class="update-log">
          <div slot="header" class="clearfix">
            <span>捐赠支持</span>
          </div>
          <div class="body">
            <img
              src="https://foruda.gitee.com/images/1672215449995765124/596b46c3_2042292.png"
              alt="donate"
              width="100%"
            />
            <span style="display: inline-block; height: 30px; line-height: 30px"
            >可以请作者喝杯咖啡以示鼓励！</span
            >
          </div>
        </el-card>
      </el-col>
    </el-row>
    <el-divider />
    <el-row :gutter="20">
      <el-col :xs="24" :sm="24" :md="12" :lg="8">
        <el-card class="update-log">
          <div slot="header" class="clearfix">
            <span>流程功能列表</span>
          </div>
          <p>1.单节点配置表单</p>
          <p>2.多实例会签任务</p>
          <p>3.节点任务/执行监听器</p>
          <p>4.动态配置任务候选人</p>
          <p>5.其它模块优化</p>
        </el-card>
      </el-col>
      <el-col :xs="24" :sm="24" :md="12" :lg="16">
        <el-card class="update-log">
          <div slot="header" class="clearfix">
            <span>流程演示</span>
          </div>
          <img style="width: 850px" src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f248dea817f74341b70f4087f425975b~tplv-k3u1fbpfcp-watermark.image?"/>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: "index",
  data() {
    return {
      // 版本号
      version: "3.4.0",
    };
  },
  methods: {
    goTarget(href) {
      window.open(href, "_blank");
    },
  },
};
</script>

<style scoped lang="scss">
.home {
  blockquote {
    padding: 10px 20px;
    margin: 0 0 20px;
    font-size: 17.5px;
    border-left: 5px solid #eee;
  }
  hr {
    margin-top: 20px;
    margin-bottom: 20px;
    border: 0;
    border-top: 1px solid #eee;
  }
  .col-item {
    margin-bottom: 20px;
  }

  ul {
    padding: 0;
    margin: 0;
  }

  font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 13px;
  color: #676a6c;
  overflow-x: hidden;

  ul {
    list-style-type: none;
  }

  h4 {
    margin-top: 0px;
  }

  h2 {
    margin-top: 10px;
    font-size: 26px;
    font-weight: 100;
  }

  p {
    margin-top: 10px;

    b {
      font-weight: 700;
    }
  }

  .update-log {
    ol {
      display: block;
      list-style-type: decimal;
      margin-block-start: 1em;
      margin-block-end: 1em;
      margin-inline-start: 0;
      margin-inline-end: 0;
      padding-inline-start: 40px;
    }
  }
}
</style>

