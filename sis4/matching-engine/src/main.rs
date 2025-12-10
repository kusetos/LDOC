use ordered_float::OrderedFloat;
use std::collections::BTreeMap;

#[derive(Clone, Copy)] enum Side { Buy, Sell }
#[derive(Clone, Copy)] enum T { L(f64), M }
#[derive(Clone)] struct O { id:u64, s:Side, t:T, q:f64 }

struct Book { b:BTreeMap<OrderedFloat<f64>,O>, a:BTreeMap<OrderedFloat<f64>,O> }
impl Book {
    fn new()->Self{Self{b:BTreeMap::new(),a:BTreeMap::new()}}

    fn add(&mut self,o:O){
        if let T::L(p)=o.t {
            let key=OrderedFloat(p);
            if matches!(o.s,Side::Buy){ self.b.insert(key,o); }
            else { self.a.insert(key,o); }
        }
    }

    fn best(&self,o:&O)->Option<(OrderedFloat<f64>,&O)>{
        match o.s {
            Side::Buy => self.a.first_key_value().map(|(p,r)|(*p,r)),
            Side::Sell=> self.b.last_key_value().map(|(p,r)|(*p,r)),
        }
    }

    fn ok(&self,o:&O,p:f64)->bool{
        match o.t {
            T::M=>true,
            T::L(lp)=>match o.s {Side::Buy=>lp>=p,Side::Sell=>lp<=p}
        }
    }

    fn match_o(&mut self,mut o:O){
        while o.q>0.0 {
            let Some((pk,r))=self.best(&o) else{break};
            let p=pk.0;
            if !self.ok(&o,p){break;}
            let qty=o.q.min(r.q);
            println!("TRADE id{} x id{} @{} qty{}",o.id,r.id,p,qty);
            o.q-=qty;
            if matches!(o.s,Side::Buy){ self.a.remove(&pk); }
            else { self.b.remove(&pk); }
        }
        if o.q>0.0 { if let T::L(_)=o.t { self.add(o) } }
    }
}

fn main(){
    let mut b=Book::new();
    println!("mock mathcnig started");
    loop {
        b.add(O{id:1,s:Side::Sell,t:T::L(101.0),q:5.0});
        b.add(O{id:2,s:Side::Buy,t:T::L(99.0),q:4.0});
        b.match_o(O{id:3,s:Side::Buy,t:T::L(103.0),q:3.0});
        b.match_o(O{id:4,s:Side::Sell,t:T::M,q:2.0});

    }
    println!("mock mathcnig started")

}
