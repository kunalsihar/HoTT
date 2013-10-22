Require Import Category.Core Functor.Core SetCategory.Core.
Require Import HProp HSet.

Set Universe Polymorphism.
Set Implicit Arguments.
Generalizable All Variables.
Set Asymmetric Patterns.

Section set_coercions_definitions.
  Context `{Funext}.

  Variable C : PreCategory.

  Definition to_prop := Functor C prop_cat.
  Definition to_set := Functor C set_cat.

  Definition from_prop := Functor prop_cat C.
  Definition from_set := Functor set_cat C.
End set_coercions_definitions.

Identity Coercion to_prop_id : to_prop >-> Functor.
Identity Coercion to_set_id : to_set >-> Functor.
Identity Coercion from_prop_id : from_prop >-> Functor.
Identity Coercion from_set_id : from_set >-> Functor.

Section set_coercions.
  Context `{Funext}.

  Variable C : PreCategory.

  Definition to_prop2set (F : to_prop C) : to_set C :=
    Build_Functor C set_cat
                  (fun x => BuildhSet (F x) _)
                  (fun s d m => morphism_of F m)
                  (fun s d d' m m' => composition_of F s d d' m m')
                  (fun x => identity_of F x).

  Definition from_set2prop (F : from_set C) : from_prop C
    := Build_Functor prop_cat C
                     (fun x => F (BuildhSet x _))
                     (fun s d m => morphism_of F (m : morphism
                                                        set_cat
                                                        (BuildhSet s _)
                                                        (BuildhSet d _)))
                     (fun s d d' m m' => composition_of F
                                                        (BuildhSet s _)
                                                        (BuildhSet d _)
                                                        (BuildhSet d' _)
                                                        m
                                                        m')
                     (fun x => identity_of F (BuildhSet x _)).
End set_coercions.

Coercion to_prop2set : to_prop >-> to_set.
Coercion from_set2prop : from_set >-> from_prop.
