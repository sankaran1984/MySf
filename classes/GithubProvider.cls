global class GithubProvider extends DataSource.Provider {

    override global List<DataSource.Capability> getCapabilities() {
        return new List<DataSource.Capability>{DataSource.Capability.ROW_QUERY};
    }
    
    override global List<DataSource.AuthenticationCapability> getAuthenticationCapabilities() {
        return new List<DataSource.AuthenticationCapability>{DataSource.AuthenticationCapability.ANONYMOUS};
    }
    
    override global DataSource.Connection getConnection(DataSource.ConnectionParams cp) {
        return new GithubAdapter();
    }
}