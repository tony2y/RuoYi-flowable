<template>
  <div
      class="el-input-tag input-tag-wrapper"
      :class="[size ? 'el-input-tag--' + size : '']"
      @click="focusTagInput">
    <el-tag
        v-for="(tag, idx) in innerTags"
        v-bind="$attrs"
        :key="tag"
        :size="size"
        effect="dark"
        closable
        :disable-transitions="false"
        @close="remove(idx)">
      {{tag}}
    </el-tag>
    <input
        v-if="!readOnly"
        class="tag-input"
        :placeholder="placeholder"
        @input="inputTag"
        :value="newTag"
        @keydown.delete.stop = "removeLastTag"
    />
<!--    @keydown = "addNew"
        @blur = "addNew"-->
  </div>
</template>


<script>
import {StrUtil} from '@/utils/StrUtil'

export default {
  name: "ElInputTag",
  /** 组件传值  */
  props : {
    value: {
      type: String,
      default: ""
    },
    addTagOnKeys: {
      type: Array,
      default: () => []
    },
    size: {
      type: String,
      default: 'small'
    },
    placeholder: String,
  },
  data() {
    return {
       newTag :"",
       innerTags :[],
       readOnly :true,
    }
  },
  /** 传值监听 */
  watch: {
    value: {
      handler(newVal) {
        if (StrUtil.isNotBlank(newVal)) {
          this.innerTags = newVal.split(',');
        }else {
          this.innerTags = [];
        }
      },
      immediate: true, // 立即生效
    },
  },
  methods: {
    focusTagInput() {
      if (this.readOnly || !this.$el.querySelector('.tag-input')) {
        return
      } else {
        this.$el.querySelector('.tag-input').focus()
      }
    },

    inputTag(ev) {
     this.newTag = ev.target.value
    },

    addNew(e) {
      if (e && (!this.addTagOnKeys.includes(e.keyCode)) && (e.type !== 'blur')) {
        return
      }
      if (e) {
        e.stopPropagation()
        e.preventDefault()
      }
      let addSuccess = false
      if (this.newTag.includes(',')) {
       this.newTag.split(',').forEach(item => {
          if (this.addTag(item.trim())) {
            addSuccess = true
          }
        })
      } else {
        if (this.addTag(this.newTag.trim())) {
          addSuccess = true
        }
      }
      if (addSuccess) {
        this.tagChange()
       this.newTag = ''
      }
    },

    addTag(tag) {
      tag = tag.trim()
      if (tag && !this.innerTags.includes(tag)) {
        this.innerTags.push(tag)
        return true
      }
      return false
    },

    remove(index) {
      this.innerTags.splice(index, 1)
      this.tagChange();
    },

    removeLastTag() {
      if (this.newTag) {
        return
      }
      this.innerTags.pop()
      this.tagChange()
    },

    tagChange() {
      this.$emit('input', this.innerTags)
    }
  }
}

</script>

<style scoped>
.el-form-item.is-error .el-input-tag {
  border-color: #f56c6c;
}
.input-tag-wrapper {
  position: relative;
  font-size: 14px;
  background-color: #fff;
  background-image: none;
  border-radius: 4px;
  border: 1px solid #dcdfe6;
  box-sizing: border-box;
  color: #606266;
  display: inline-block;
  outline: none;
  padding: 0 10px 0 5px;
  transition: border-color .2s cubic-bezier(.645,.045,.355,1);
  width: 100%;
}
.el-tag {
  margin-right: 4px;
}

.tag-input {
  background: transparent;
  border: 0;
  font-size: inherit;
  outline: none;
  padding-left: 0;
  width: 100px;
}
.el-input-tag {
  min-height: 42px;
}
.el-input-tag--small {
  min-height: 32px;
  line-height: 32px;
  font-size: 12px;
}

.el-input-tag--default {
  min-height: 34px;
  line-height: 34px;
}

.el-input-tag--large {
  min-height: 36px;
  line-height: 36px;
}

</style>
