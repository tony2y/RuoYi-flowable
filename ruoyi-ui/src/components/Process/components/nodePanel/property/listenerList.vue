<template>
  <el-dialog title="内置监听器"
             width="900px"
             :visible.sync="dialogVisible"
             append-to-body
             :close-on-click-modal="false"
             :close-on-press-escape="false"
             :show-close="false"
             :before-close="close"
  >
    <flow-listener @handleSelect="handleSelect"/>
    <span slot="footer" class="dialog-footer">
      <el-button @click="close">取 消</el-button>
      <el-button type="primary" @click="checkComplete">确 定</el-button>
    </span>
  </el-dialog>
</template>

<script>
  import FlowListener from '@/components/flow/Listener'

  export default {
    name: 'ListentList',
    components: { FlowListener },
    props: {
      visible: {
        type: Boolean,
        default: false
      }
    },
    data() {
      return {
        dialogVisible: this.visible,
        listenerList: []
      }
    },
    watch: {
      visible: {
        handler(newVal) {
          this.dialogVisible = newVal
        },
        immediate: true,
        deep: true
      }
    },
    methods: {
      close() {
        this.dialogVisible = false
        this.$emit('close')
      },
      checkComplete() {
        this.close()
        this.$emit('submit', this.listenerList)
      },
      handleSelect(selection) {
        const type = ['class', 'expression', 'delegateExpression']
        let list = []
        selection.forEach(data => {
          const formData = {
            event: data.eventType,
            type: type[parseInt(data.valueType) - 1],
            className: data.value
          }
          list.push(formData)
        })
        this.listenerList = list
      }
    }
  }
</script>

<style></style>
