const state={gu:true,screen:'home',cart:[],paper:'58 mm',auto:true,kot:true,dup:false};
const items=[['પનીર બટર મસાલા','Paneer Butter Masala',120],['રોટલી','Roti',15],['દાળ તડકા','Dal Tadka',70],['છાશ','Chaas',25],['કાઠિયાવાડી થાળી','Kathiyawadi Thali',180],['બાજરી રોટલો','Bajra Rotla',35]];
const T=(g,e)=>state.gu?g:e;
const money=n=>'₹ '+n;
function render(){
 document.getElementById('lang').textContent=state.gu?'EN':'ગુજરાતી';
 const a=document.getElementById('app');
 if(state.screen==='home') home(a);
 if(state.screen==='billing') billing(a);
 if(state.screen==='settings') settings(a);
 if(['kot','tables','stock','customer','reports'].includes(state.screen)) placeholder(a,state.screen);
 bottom();
}
function home(a){
 const tiles=[['🧾','બિલિંગ','Billing','billing'],['🍳','KOT / કિચન','KOT / Kitchen','kot'],['🪑','ટેબલ','Tables','tables'],['📦','આઇટમ / સ્ટોક','Items / Stock','stock'],['👤','ગ્રાહક','Customer','customer'],['📊','રિપોર્ટ','Reports','reports'],['⚙️','સેટિંગ્સ','Settings','settings']];
 a.innerHTML='<h2>'+T('ડેશબોર્ડ','Dashboard')+'</h2><div class="grid">'+tiles.map(x=>`<button class="card" onclick="go('${x[3]}')"><span class="icon">${x[0]}</span><b>${T(x[1],x[2])}</b></button>`).join('')+'</div>';
}
function billing(a){
 let total=state.cart.reduce((s,x)=>s+x[2]*x[3],0);
 a.innerHTML='<h2>'+T('ઝડપી બિલિંગ','Fast Billing')+'</h2><div class="panel"><input class="search" placeholder="'+T('આઇટમ શોધો...','Search item...')+'" oninput="filterItems(this.value)"></div><div id="items" class="panel"></div><div class="panel"><div class="total">'+T('કુલ','Total')+': '+money(total)+'</div><button class="pay" onclick="pay()">'+T('પેમેન્ટ','Payment')+'</button></div>';
 showItems('');
}
function showItems(q){
 const el=document.getElementById('items'); if(!el)return;
 const arr=items.filter(x=>(x[0]+x[1]).toLowerCase().includes(q.toLowerCase()));
 el.innerHTML=arr.map((x,i)=>`<div class="item"><div><b>${T(x[0],x[1])}</b><br><small>${money(x[2])}</small></div><button class="add" onclick="add(${items.indexOf(x)})">+ ${T('ઉમેરો','Add')}</button></div>`).join('');
}
function filterItems(q){showItems(q)}
function add(i){const x=items[i];let c=state.cart.find(y=>y[0]===x[0]);if(c)c[3]++;else state.cart.push([x[0],x[1],x[2],1]);render()}
function pay(){alert(T('બિલ તૈયાર છે! કુલ: ','Bill ready! Total: ')+money(state.cart.reduce((s,x)=>s+x[2]*x[3],0)));state.cart=[];render()}
function settings(a){
 a.innerHTML='<h2>'+T('પ્રિન્ટર સેટિંગ્સ','Printer Settings')+'</h2><div class="panel"><div class="setting"><b>Printer</b><select id="printer"><option>Bluetooth Printer</option><option>USB Printer</option><option>Network Printer</option></select></div><div class="setting"><b>'+T('પેપર સાઇઝ','Paper Size')+'</b><select onchange="state.paper=this.value"><option>58 mm</option><option>80 mm</option></select></div>'+[['auto','Auto Print after Billing'],['kot','Print Kitchen Order (KOT)'],['dup','Print Duplicate Bill']].map(x=>`<div class="setting"><span>${x[1]}</span><input type="checkbox" ${state[x[0]]?'checked':''} onchange="state.${x[0]}=this.checked"></div>`).join('')+'<button class="pay" onclick="alert(T('ટેસ્ટ પ્રિન્ટ મોકલ્યો!\',\'Test print sent!\'))">🖨️ '+T('ટેસ્ટ પ્રિન્ટ','Test Print')+'</button></div>';
}
function placeholder(a,s){const map={kot:['🍳','KOT / Kitchen'],tables:['🪑','Tables'],stock:['📦','Items / Stock'],customer:['👤','Customer'],reports:['📊','Reports']};a.innerHTML='<h2>'+T(map[s][1],map[s][1])+'</h2><div class="panel empty">'+map[s][0]+'<br>'+T('આ મોડ્યુલ આગળના વર્ઝનમાં','Module ready for the next version')+'</div>'}
function bottom(){document.getElementById('bottom').className='bottom';document.getElementById('bottom').innerHTML=[['home','⌂','Home'],['billing','🧾','Billing'],['settings','⚙️','Settings']].map(x=>`<button class="${state.screen===x[0]?'active':''}" onclick="go('${x[0]}')">${x[1]}<br>${T(x[2],x[2])}</button>`).join('')}
function go(s){state.screen=s;render()}
document.getElementById('lang').onclick=()=>{state.gu=!state.gu;render()};
if('serviceWorker' in navigator) navigator.serviceWorker.register('sw.js');
render();