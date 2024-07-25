// const sendMessage = {
//     // pageにアクセスしたときに呼ばれるところ
//     //一回目で呼ばれる
// mounted(){
//     const input = document.getElementById('input-message');

//     input.addEventListener('keypress', (e)/*key_press から来てる　-> e = eventを発火したときの引数*/  => {
//         console.log('Enter: ', e.key == 'Enter', '| Ctrl :', e.ctrlKey)
//         if(e.key == 'Enter')
//         {
//             if(e.ctrlKey)
//             {
//                 //show.ex
//                 this.pushEvent('send_message', {message: {message: e.target.value}});
//                 e.target.value = '';
//             };
//             e.preventDefault();
//             return false;
//         }
//     });
// }
// // updated(){
// //     console.log('call updated');
// // }
// };

// export {sendMessage};

const sendMessage = {
    mounted() {
      const input = document.getElementById('input-message');
  
      let enter = false;
      let ctrl = false;
  
      input.addEventListener('keydown', (e) => {
        if (e.key == 'Enter')
        {
          enter = true;
          e.preventDefault();
        }
  
        if (e.ctrlKey)
        {
          ctrl = true;
        }
  
        if(enter && ctrl)
        {
          this.pushEvent('send_message', {message: {message: e.target.value}});
          //「送ったらテキストボックスから消す」という処理
          e.target.value = '';
        }
        return false;
      });
  
      input.addEventListener('keyup', (e) => {
        if (e.key == 'Enter')
        {
          enter = false;
          e.preventDefault()
        }
  
        if (e.ctrlKey)
        {
          ctrl = false;
        }
  
        return false;
      });
    }
  };

  const scrollMessage = {
    mounted(){
        scroll();
    },
    updated(){
        scroll();
    }

    
  }
  
  const scroll = () => {
    const scrollBox = document.getElementById('scroll-box');
    //最新のところ（ボトム）を画面のtopにあてると最新がみられる
    scrollBox.scrollTop = scrollBox.scrollHeight;
}
  
  export {sendMessage, scrollMessage};