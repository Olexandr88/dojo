#[derive($model_value_derive_attr_names$)]
pub struct $model_type$Value {
    $members_values$
} 

type $model_type$KeyType = $key_type$;

pub impl $model_type$KeyParser of dojo::model::model::KeyParser<$model_type$, $model_type$KeyType>{
    #[inline(always)]
    fn parse_key(self: @$model_type$) -> $model_type$KeyType {
        $keys_to_tuple$
    }
}

impl $model_type$ModelValueKey of dojo::model::model_value::ModelValueKey<$model_type$Value, $model_type$KeyType> {
}

// Impl to get the static definition of a model
pub mod $model_type_snake$_definition {
    use super::$model_type$;
    pub impl $model_type$DefinitionImpl<T> of dojo::model::ModelDefinition<T>{
        #[inline(always)]
        fn name() -> ByteArray {
            "$model_type$"
        }

        #[inline(always)]
        fn version() -> u8 {
            $model_version$
        }

        #[inline(always)]
        fn layout() -> dojo::meta::Layout {
            dojo::meta::Introspect::<$model_type$>::layout()
        }

        #[inline(always)]
        fn schema() -> dojo::meta::introspect::Ty {
            dojo::meta::Introspect::<$model_type$>::ty()
        }

        #[inline(always)]
        fn size() -> Option<usize> {
            dojo::meta::Introspect::<$model_type$>::size()
        }
    }
}

pub impl $model_type$Definition = $model_type_snake$_definition::$model_type$DefinitionImpl<$model_type$>;
pub impl $model_type$ModelValueDefinition = $model_type_snake$_definition::$model_type$DefinitionImpl<$model_type$Value>;

pub impl $model_type$ModelParser of dojo::model::model::ModelParser<$model_type$>{
    fn serialize_keys(self: @$model_type$) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        $serialized_keys$
        core::array::ArrayTrait::span(@serialized)
    }
    fn serialize_values(self: @$model_type$) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        $serialized_values$
        core::array::ArrayTrait::span(@serialized)
    }
} 

pub impl $model_type$ModelValueParser of dojo::model::model_value::ModelValueParser<$model_type$Value>{
    fn serialize_values(self: @$model_type$Value) -> Span<felt252> {
        let mut serialized = core::array::ArrayTrait::new();
        $serialized_values$
        core::array::ArrayTrait::span(@serialized)
    }
}

pub impl $model_type$ModelImpl = dojo::model::model::ModelImpl<$model_type$>;
pub impl $model_type$ModelValueImpl = dojo::model::model_value::ModelValueImpl<$model_type$Value>;

#[starknet::contract]
pub mod $model_type_snake$ {
    use super::$model_type$;
    use super::$model_type$Value;

    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl $model_type$__DojoModelImpl = dojo::model::component::IModelImpl<ContractState, $model_type$>;

    #[abi(per_item)]
    #[generate_trait]
    impl $model_type$Impl of I$model_type${
        // Ensures the ABI contains the Model struct, even if never used
        // into as a system input.
        #[external(v0)]
        fn ensure_abi(self: @ContractState, model: $model_type$) {
            let _model = model;
        }

        // Outputs ModelValue to allow a simple diff from the ABI compared to the
        // model to retrieved the keys of a model.
        #[external(v0)]
        fn ensure_values(self: @ContractState, value: $model_type$Value) {
            let _value = value;
        }
    }
}


#[cfg(target: "test")]
pub impl $model_type$ModelTestImpl<S, +dojo::model::storage::ModelStorageTest<S, $model_type$>> = dojo::model::model::ModelTestImpl<S, $model_type$>;

#[cfg(target: "test")]
pub impl $model_type$ModelValueTestImpl<S, +dojo::model::storage::ModelValueStorageTest<S, $model_type$Value>> = dojo::model::model_value::ModelValueTestImpl<S, $model_type$Value>;
