use dojo::model::model_value::ModelValueKey;

/// A `ModelStorage` trait that abstracts where the storage is.
///
/// Currently it's only world storage, but this will be useful when we have other
/// storage solutions (micro worlds).
pub trait ModelStorage<S, M> {
    /// Sets a model of type `M`.
    fn write_model(ref self: S, model: @M);

    /// Retrieves a model of type `M` using the provided key of type `K`.
    fn read_model<K, +Drop<K>, +Serde<K>>(self: @S, key: K) -> M;

    /// Deletes a model of type `M`.
    fn erase_model(ref self: S, model: @M);

    /// Deletes a model of type `M` using the provided key of type `K`.
    fn erase_model_from_key<K, +Drop<K>, +Serde<K>>(ref self: S, key: K);

    /// Retrieves a member of type `T` from a model of type `M` using the provided member id and key
    /// of type `K`.
    fn read_member<T, K, +MemberModelStorage<S, M, T>, +Drop<T>, +Drop<K>, +Serde<K>>(
        self: @S, key: K, member_id: felt252
    ) -> T;

    /// Updates a member of type `T` within a model of type `M` using the provided member id, key of
    /// type `K`, and new value of type `T`.
    fn write_member<T, K, +MemberModelStorage<S, M, T>, +Drop<T>, +Drop<K>, +Serde<K>>(
        ref self: S, key: K, member_id: felt252, value: T
    );

    /// Returns the current namespace hash.
    fn namespace_hash(self: @S) -> felt252;
}

/// A `MemberModelStorage` trait that abstracts where the storage is.
pub trait MemberModelStorage<S, M, T> {
    /// Retrieves a member of type `T` for the given entity id and member id.
    fn read_member(self: @S, entity_id: felt252, member_id: felt252) -> T;

    /// Updates a member of type `T` for the given entity id and member id.
    fn write_member(ref self: S, entity_id: felt252, member_id: felt252, value: T);

    /// Returns the current namespace hash.
    fn namespace_hash(self: @S) -> felt252;
}

/// A `ModelStorage` trait that abstracts where the storage is.
///
/// Currently it's only world storage, but this will be useful when we have other
/// storage solutions (micro worlds).
pub trait ModelStorageTest<S, M> {
    /// Sets a model of type `M`.
    fn write_model_test(ref self: S, model: @M);
    /// Deletes a model of type `M`.
    fn erase_model_test(ref self: S, model: @M);
}

/// A `ModelValueStorage` trait that abstracts where the storage is.
pub trait ModelValueStorage<S, V> {
    /// Retrieves a model value of type `V` using the provided key of type `K`.
    fn read_model_value<K, +Drop<K>, +Serde<K>, +ModelValueKey<V, K>>(self: @S, key: K) -> V;

    /// Retrieves a model value of type `V` using the provided entity id.
    fn read_model_value_from_id(self: @S, entity_id: felt252) -> V;

    /// Updates a model value of type `V`.
    fn write_model_value(ref self: S, entity_id: felt252, value: @V);

    /// Deletes a model value of type `V` using the provided entity id.
    fn erase_model_value_from_id(ref self: S, entity_id: felt252);

    /// Retrieves a member of type `T` from a model value of type `V` using the provided member id.
    fn read_member_from_id<T, +MemberModelStorage<S, V, T>>(
        self: @S, entity_id: felt252, member_id: felt252
    ) -> T;

    /// Updates a member of type `T` within a model value of type `V` using the provided member id.
    fn write_member_from_id<T, +MemberModelStorage<S, V, T>>(
        ref self: S, entity_id: felt252, member_id: felt252, value: T
    );
}

/// A `ModelValueStorageTest` trait that abstracts where the storage is and bypass the permission
/// checks.
pub trait ModelValueStorageTest<S, V> {
    /// Updates a model value of type `V`.
    fn write_model_value_test(ref self: S, entity_id: felt252, value: @V);
    /// Deletes a model value of type `V`.
    fn erase_model_value_test(ref self: S, entity_id: felt252);
}
